//
//  String.swift
//  SSCommon
//
//  Created by zhtg on 2023/4/26.
//

import Foundation

public extension String {

    /// Create `Data` from hexadecimal string representation
    ///
    /// This creates a `Data` object from hex string. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.
    var hexData: Data? {
        var data = Data(capacity: count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            if let num = UInt8(byteString, radix: 16) {
                data.append(num)
            }
        }

        guard data.count > 0 else { return nil }

        return data
    }
    
    func split(_ separator: Character) -> [String] {
        split(separator: separator)
            .map({ "\($0)" })
    }
}

public extension String {
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func suffix(from: String) -> String {
        if let startRange = range(of: from) {
            let str = suffix(from: startRange.upperBound)
            return "\(str)"
        }
        return self
    }
    
    func prefix(to: String) -> String {
        if let endRange = self.range(of: to) {
            let str = prefix(upTo: endRange.lowerBound)
            return "\(str)"
        }
        return self
    }
    
    var double: Double? {
        return Double(self)
    }
    
    func defaultDouble(_ `default`: Double = 0.0) -> Double {
        return double ?? `default`
    }
    
    var int: Int? {
        return Int(self)
    }
    
    func defaultInt(_ `default`: Int = 0) -> Int {
        return int ?? `default`
    }
    
    var decimal: Decimal? {
        return Decimal(string: self)
    }
    
    func defaultDecimal(_ `default`: Decimal = 0.0) -> Decimal {
        return decimal ?? `default`
    }
    
    var precision: Int {
        var newPre = self
        while newPre.hasSuffix("0") {
            newPre = "\(newPre.prefix(newPre.count - 2))"
        }
        let arr = newPre.components(separatedBy: ".")
        if arr.count == 1 {
            return 0
        }
        if let str = arr.last {
            return str.count
        }
        return 0
    }
    
    func urlEncodeString() -> String? {
        let characters = "!*'();:@&=+$,/?%#[]"
        let set = CharacterSet(charactersIn: characters).inverted
        let str = self.addingPercentEncoding(withAllowedCharacters: set)
        return str
    }
}
