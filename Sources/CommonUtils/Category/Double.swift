//
//  Double.swift
//  common-utils
//
//  Created by tutuzhou on 2025/11/8.
//

import Foundation

public extension Double {
    var string: String {
        return "\(self)"
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
