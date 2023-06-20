//
//  WeatherError.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import Foundation

public enum WeatherErrorDescription: String {
    case invalidURL = "Unable to create URL"
}

public enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
}
