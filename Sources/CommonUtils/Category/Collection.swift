//
//  GetValue.swift
//  common-utils
//
//  Created by tutuzhou on 2025/11/8.
//

import Foundation

public struct ValueError: Error {
    var message: String
}

public extension Dictionary {
    
    func string(for key: Key) -> String? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.string(from: value)
    }
    
    func requireString(for key: Key) throws -> String {
        let value = try requireValue(for: key)
        return try CommonUtils.requireString(from: value)
    }
    
    func bool(for key: Key) -> Bool? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.bool(from: value)
    }
    
    func requireBool(for key: Key) throws -> Bool {
        let value = try requireValue(for: key)
        return try CommonUtils.requireBool(from: value)
    }
    
    func int(for key: Key) -> Int? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.int(from: value)
    }
    
    func requireInt(for key: Key) throws -> Int {
        let value = try requireValue(for: key)
        return try CommonUtils.requireInt(from: value)
    }
    
    func double(for key: Key) -> Double? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.double(from: value)
    }
    
    func requireDouble(for key: Key) throws -> Double {
        let value = try requireValue(for: key)
        return try CommonUtils.requireDouble(from: value)
    }
    
    func array(for key: Key) -> [Any]? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.array(from: value)
    }
    
    func require(for key: Key) throws -> [Any] {
        let value = try requireValue(for: key)
        return try CommonUtils.requireArray(from: value)
    }
    
    func dictionary(for key: Key) -> [String: Any]? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.dictionary(from: value)
    }
    
    func require(for key: Key) throws -> [String: Any] {
        let value = try requireValue(for: key)
        return try CommonUtils.requireDictionary(from: value)
    }
    
    func requireValue(for key: Key) throws -> Value {
        guard let value = self[key] else {
            throw ValueError(message: "\(self) not has a value with key \(key)")
        }
        return value
    }
}

public extension Array {
    
    func string(at index: Int) -> String? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.string(from: value)
    }
    
    func require(at index: Int) throws -> String {
        let value = try requireValue(at: index)
        return try CommonUtils.requireString(from: value)
    }
    
    func bool(at index: Int) -> Bool? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.bool(from: value)
    }
    
    func require(at index: Int) throws -> Bool {
        let value = try requireValue(at: index)
        return try CommonUtils.requireBool(from: value)
    }
    
    func int(at index: Int) -> Int? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.int(from: value)
    }
    
    func require(at index: Int) throws -> Int {
        let value = try requireValue(at: index)
        return try CommonUtils.requireInt(from: value)
    }
    
    func double(at index: Int) -> Double? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.double(from: value)
    }
    
    func require(at index: Int) throws -> Double {
        let value = try requireValue(at: index)
        return try CommonUtils.requireDouble(from: value)
    }
    
    func array(at index: Int) -> [Any]? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.array(from: value)
    }
    
    func require(at index: Int) throws -> [Any] {
        let value = try requireValue(at: index)
        return try CommonUtils.requireArray(from: value)
    }
    
    func dictionary(at index: Int) -> [String: Any]? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.dictionary(from: value)
    }
    
    func require(at index: Int) throws -> [String: Any] {
        let value = try requireValue(at: index)
        return try CommonUtils.requireDictionary(from: value)
    }
    
    func requireValue(at index: Int) throws -> Element {
        guard count > index else {
            throw ValueError(message: "\(index) is greater than the size of the array \(count)")
        }
        return self[index]
    }
}

public func string(from value: Any) -> String? {
    if let value = value as? String {
        return value
    } else if let value = value as? Bool {
        return "\(value)"
    } else if let value = value as? Int {
        return "\(value)"
    } else if let value = value as? Double {
        return "\(value)"
    }
    
    return nil
}

public func requireString(from value: Any) throws -> String {
    if let value = value as? String {
        return value
    } else if let value = value as? Bool {
        return "\(value)"
    } else if let value = value as? Int {
        return "\(value)"
    } else if let value = value as? Double {
        return "\(value)"
    }
    throw ValueError(message: "\(value) cannot be converted to a string.")
}

public func bool(from value: Any) -> Bool? {
    if let value = value as? Bool {
        return value
    } else if let value = value as? String {
        return value.isNotEmpty
    } else if let value = value as? Int {
        return value != 0
    } else if let value = value as? Double {
        return value != 0
    }
    return false
}

public func requireBool(from value: Any) throws -> Bool {
    if let value = value as? Bool {
        return value
    } else if let value = value as? String {
        return value.isNotEmpty
    } else if let value = value as? Int {
        return value != 0
    } else if let value = value as? Double {
        return value != 0
    }
    throw ValueError(message: "\(value) cannot be converted to a bool.")
}

public func double(from value: Any) -> Double? {
    if let value = value as? Double {
        return value
    } else if let value = value as? Int {
        return Double(value)
    } else if let value = value as? String {
        return Double(value)
    } else if let value = value as? Bool {
        return value ? 1.0 : 0
    }
    return nil
}

public func requireDouble(from value: Any) throws -> Double {
    if let value = value as? Double {
        return value
    } else if let value = value as? Int {
        return Double(value)
    } else if let value = value as? String, let d = Double(value) {
        return d
    } else if let value = value as? Bool {
        return value ? 1.0 : 0
    }
    throw ValueError(message: "\(value) cannot be converted to a Double.")
}

public func int(from value: Any) -> Int? {
    if let value = value as? Int {
        return value
    } else if let value = value as? Double {
        return Int(value)
    } else if let value = value as? String {
        return Int(value)
    } else if let value = value as? Bool {
        return value ? 1 : 0
    }
    return nil
}

public func requireInt(from value: Any) throws -> Int {
    if let value = value as? Int {
        return value
    } else if let value = value as? Double {
        return Int(value)
    } else if let value = value as? String, let i = Int(value) {
        return i
    } else if let value = value as? Bool {
        return value ? 1 : 0
    }
    throw ValueError(message: "\(value) cannot be converted to a Int.")
}

public func array(from value: Any) -> [Any]? {
    if let value = value as? [Any] {
        return value
    }
    return nil
}

public func requireArray(from value: Any) throws -> [Any] {
    if let value = value as? [Any] {
        return value
    }
    throw ValueError(message: "\(value) cannot be converted to a array.")
}

public func dictionary(from value: Any) -> [String: Any]? {
    if let value = value as? [String: Any] {
        return value
    }
    return nil
}

public func requireDictionary(from value: Any) throws -> [String: Any] {
    if let value = value as? [String: Any] {
        return value
    }
    throw ValueError(message: "\(value) cannot be converted to a dictionary.")
}
