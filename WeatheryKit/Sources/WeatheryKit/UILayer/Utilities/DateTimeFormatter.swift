//
//  DateTimeFormatter.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import Foundation

public class DateTimeFormatter {
    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()

    static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
}
