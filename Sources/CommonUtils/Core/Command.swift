//
//  File.swift
//
//
//  Created by zhtg on 2022/9/24.
//

import Foundation

#if os(macOS) || os(Linux)

extension ArraySlice where Element == String {
    func mergeArguments() -> [String] {
        var newArgs = [String]()
        var curr = ""
        for str in self {
            if curr.count != 0 {
                if str.isIncompleted {
                    curr += str
                    newArgs.append(curr)
                    curr = ""
                } else {
                    curr += str
                }
            } else {
                if str.isIncompleted {
                    curr = str
                } else {
                    newArgs.append(str)
                }
            }
        }
        return newArgs
    }
}

extension String {
    var isIncompleted: Bool {
        if self.characterCount("\"") % 2 != 0 || self.characterCount("'") % 2 != 0 {
            return true
        }
        return false
    }
    
    func characterCount(_ char: Character) -> Int {
        var count = 0
        for c in self {
            let cStr = "\(c)"
            let charStr = "\(char)"
            if cStr == charStr {
                count += 1
            }
        }
        return count
    }
}

func findCommandPath(_ command: String) async throws -> String {
    let fm = FileManager.default
    if fm.fileExists(atPath: command) {
        return command
    }
    
    let paths = [
        "/usr/local/bin",
        "/usr/bin",
        "/bin",
        "/usr/sbin",
        "/sbin",
        "/Library/Apple/usr/bin",
        "/usr/local/sbin",
        "/usr/games",
        "/usr/local/games",
        "/snap/bin",
    ]
    for pa in paths {
        let full = pa + "/\(command)"
        if fm.fileExists(atPath: full) {
            return full
        }
    }
    throw CommonError(message: "command not found: \(command)")
}

/// 执行单个命令，如mkdir test, git pull等，只支持单个
@discardableResult
public func runCommand(_ command: String,
                       currentDir: String? = nil,
                       args: [String] = []) async throws -> String {
    let task = Process()
    let array = command.components(separatedBy: " ")
    
    // command
    guard let commandName = array.first else {
        throw CommonError(message: "command not found: \(command)")
    }
    let commandPath = try await findCommandPath(commandName)
    let url = URL(fileURLWithPath: commandPath)
    task.executableURL = url
    
    // currentDir
    if let currentDir = currentDir {
        let currentDirURL = URL(fileURLWithPath: currentDir)
        task.currentDirectoryURL = currentDirURL
    }
    
    // arguments
    let other = array.dropFirst()
    var arguments = other.mergeArguments()
    if args.count > 0 {
        arguments += args
    }
    task.arguments = arguments
    
    // pipe
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    
    // run
    try task.run()
    
    // result
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8) ?? ""
    
    let argumentStr = arguments.joined(separator: " ")
    print("----command:\n\(commandPath) \(argumentStr)\n-----output:\(output)")
    
    task.waitUntilExit()
    
    if task.terminationStatus == 0 {
        // 删除两边的空格和换行
        return output.trimmingCharacters(in: .newlines)
    } else {
        throw CommonError(code: Int(task.terminationStatus), message: "command not found: \(command)")
    }
}

#endif
