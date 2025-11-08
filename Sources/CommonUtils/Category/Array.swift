//
//  SSCommon.swift
//  Pods
//
//  Created by shutut on 2021/7/28.
//

import Foundation

public extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        if let index = firstIndex(of: element) {
           remove(at: index)
        }
    }
}
