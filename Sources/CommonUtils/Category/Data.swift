//
//  Data.swift
//  SSCommon
//
//  Created by zhtg on 2023/4/26.
//

import Foundation

public extension Sequence where Element == UInt8 {
    var hex: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}

public extension Data {
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}

public extension Array where Element == UInt8 {
    var data: Data {
        return Data(self)
    }
}
