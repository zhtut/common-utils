//
//  Json.swift
//  common-utils
//
//  Created by tutuzhou on 2025/11/8.
//

import Foundation

public extension Array {
    var jsonString: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let str = String(data: data, encoding: .utf8)
            return str
        }
        return nil
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
}
