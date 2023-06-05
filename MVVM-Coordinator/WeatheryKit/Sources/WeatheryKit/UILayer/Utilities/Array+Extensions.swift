//
//  Array+Extensions.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 5/6/2023.
//

import Foundation

public extension Array where Element: Hashable {
    static func removeDuplicates(_ elements: [Element]) -> [Element] {
        var seen = Set<Element>()
        return elements.filter{ seen.insert($0).inserted }
    }
}
