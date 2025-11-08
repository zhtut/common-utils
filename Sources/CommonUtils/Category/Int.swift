//
//  Int.swift
//  common-utils
//
//  Created by tutuzhou on 2025/11/8.
//

import Foundation

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
