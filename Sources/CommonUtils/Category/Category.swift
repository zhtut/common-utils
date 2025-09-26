//
//  SSCommon.swift
//  Pods
//
//  Created by shutut on 2021/7/28.
//

import Foundation

public func max<T: Comparable>(_ a: T, _ b: T) -> T {
    return a > b ? a : b
}

public func min<T: Comparable>(_ a: T, _ b: T) -> T {
    return a < b ? a : b
}

public func dabs(_ a: Decimal) -> Decimal {
    return a < 0 ? -a : a
}

public extension Array {
    var jsonStr: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let str = String(data: data, encoding: .utf8)
            return str
        }
        return nil
    }
}

public extension Decimal {
    var double: Double? {
        return Double(exactly: self as NSNumber)
    }
    var string: String {
        return "\(self)"
    }
    /// 取精度
    /// - Parameter count: 小数点后几位
    /// - Returns: 获取精度后的数据
    func precisionStringWith(count: Int) -> String {
        let format = NumberFormatter()
        format.minimumFractionDigits = 0
        format.maximumFractionDigits = count
        format.roundingMode = .halfUp
        let str = format.string(for: self)
        return str ?? ""
    }
    
    /// 取精度
    /// - Parameter precision: 精度字符串，如0.000001
    /// - Returns: 获取精度后的数据
    func precisionStringWith(precision: String) -> String {
        let count = precision.precision
        return precisionStringWith(count: count)
    }
}

public extension Dictionary {

    var jsonString: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let str = String(data: data, encoding: .utf8)
            return str
        }
        return nil
    }
    
    func stringFor(_ key: Key) -> String? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.string(from: value)
    }
    
    func boolFor(_ key: Key) -> Bool? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.bool(from: value)
    }
    
    func intFor(_ key: Key) -> Int? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.int(from: value)
    }
    
    func doubleFor(_ key: Key) -> Double? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.double(from: value)
    }
    
    func arrayFor(_ key: Key) -> [Any]? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.array(from: value)
    }

    func dictionaryFor(_ key: Key) -> [String: Any]? {
        guard let value = self[key] else {
            return nil
        }
        return CommonUtils.dictionary(from: value)
    }
}

public extension Array {
    
    var jsonString: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let str = String(data: data, encoding: .utf8)
            return str
        }
        return nil
    }
    
    func string(at index: Int) -> String? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.string(from: value)
    }
    
    func bool(at index: Int) -> Bool? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.bool(from: value)
    }
    
    func int(at index: Int) -> Int? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.int(from: value)
    }
    
    func double(at index: Int) -> Double? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.double(from: value)
    }
    
    func array(at index: Int) -> [Any]? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.array(from: value)
    }
    
    func dictionary(at index: Int) -> [String: Any]? {
        guard count > index else {
            return nil
        }
        let value = self[index]
        return CommonUtils.dictionary(from: value)
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

public func array(from value: Any) -> [Any]? {
    if let value = value as? [Any] {
        return value
    }
    return nil
}

public func dictionary(from value: Any) -> [String: Any]? {
    if let value = value as? [String: Any] {
        return value
    }
    return nil
}

public extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        if let index = firstIndex(of: element) {
           remove(at: index)
        }
    }
}

public extension Optional {
    
    var isEmpty: Bool {
        return self == nil
    }
    
    var isNotEmpty: Bool {
        return self != nil
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

public extension Double {
    var string: String {
        return "\(self)"
    }
    
    var decimal: Decimal {
        return Decimal(self)
    }
}

public extension Int {
    var string: String {
        return "\(self)"
    }
    var double: Double {
        return Double(self)
    }
    var decimal: Decimal {
        return Decimal(self)
    }
}

public extension Double {
    /// 取精度
    /// - Parameter count: 小数点后几位
    /// - Returns: 获取精度后的数据
    func precisionStringWith(count: Int) -> String {
        let format = NumberFormatter()
        format.minimumFractionDigits = 0
        format.maximumFractionDigits = count
        format.roundingMode = .halfUp
        let str = format.string(for: self)
        return str ?? ""
    }
    
    /// 取精度
    /// - Parameter precision: 精度字符串，如0.000001
    /// - Returns: 获取精度后的数据
    func precisionStringWith(precision: String) -> String {
        let count = precision.precision
        return precisionStringWith(count: count)
    }
}
