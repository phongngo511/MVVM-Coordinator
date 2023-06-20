//
//  LosslessStringConvertible+Extensions.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 5/6/2023.
//

import Foundation

public extension LosslessStringConvertible {
    var string: String { .init(self) }
}
