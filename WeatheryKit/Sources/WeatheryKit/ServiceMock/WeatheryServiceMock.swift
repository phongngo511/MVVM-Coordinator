//
//  WeatheryServiceMock.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 16/6/2023.
//

import Foundation

public struct WeatheryServiceMock {
    public enum FileError: Error {
        case fileNotFound
        case invalidType
    }

    public enum FileExtension {
        static let json = "json"
    }

    public enum FileName {
        static let weeklyWeatherDetails = "weeklyWeatherDetails"
        static let currentWeatherDetails = "currentWeatherDetails"
    }

    public static func weaklyWeatherResponseMock() throws -> [WeeklyForecastResponse.ResponseItem] {
        guard let fileURL = Bundle.module.url(forResource: FileName.weeklyWeatherDetails, withExtension: FileExtension.json)
        else {
            throw(FileError.fileNotFound)
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let items = try JSONDecoder().decode([WeeklyForecastResponse.ResponseItem].self, from: data)
            return items
        } catch {
            print(error.localizedDescription)
            throw(FileError.invalidType)
        }
    }

    public static func currentWeatherResponseMock() throws -> CurrentWeatherForecastResponse {
        guard let fileURL = Bundle.module.url(forResource: FileName.currentWeatherDetails, withExtension: FileExtension.json)
        else {
            throw(FileError.fileNotFound)
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let items = try JSONDecoder().decode(CurrentWeatherForecastResponse.self, from: data)
            return items
        } catch {
            print(error.localizedDescription)
            throw(FileError.invalidType)
        }
    }
}
