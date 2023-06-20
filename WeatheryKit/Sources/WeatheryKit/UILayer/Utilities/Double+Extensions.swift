//
//  Double+Extensions.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 5/6/2023.
//

import Foundation
public extension Double {
    func toString(withMaxFractionalDigits maxDigits: Int = 1, minDigits: Int = 0) -> String? {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = maxDigits
        formatter.minimumFractionDigits = minDigits
        return formatter.string(from: NSNumber(value: self))
    }
}
