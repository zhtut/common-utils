//
//  Optional.swift
//  common-utils
//
//  Created by tutuzhou on 2025/11/8.
//

import Foundation

public extension Optional {
    var isEmpty: Bool {
        return self == nil
    }
    
    var isNotEmpty: Bool {
        return self != nil
    }
}
