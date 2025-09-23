//
//  Error.swift
//  GoodMood
//
//  Created by zhtg on 2023/4/14.
//  Copyright © 2023 Buildyou Tech. All rights reserved.
//

import Foundation

/// 通用错误
public struct CommonError: Error, CustomStringConvertible, LocalizedError {

    public var code: Int
    public var message: String
    
    public init(code: Int = -1, message: String) {
        self.message = message
        self.code = code
    }

    public var description: String {
        return message
    }

    public var errorDescription: String {
        return message
    }
}
