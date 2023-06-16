//
//  WeatheryDummyService.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 16/6/2023.
//

import Foundation

public struct WeatheryDummyService {
    public enum DummyError: Error {
        case fileNotFound
        case invalidType
    }

    public enum fileExtension {
        static let json = "json"
    }

    public enum fileName {
        static let weeklyWeatherDetails = "weeklyWeatherDetails"
        static let currentWeatherDetails = "currentWeatherDetails"
    }

    public static func dummyWeaklyWeatherResponse() throws -> [WeeklyForecastResponse.ResponseItem] {
        guard let fileURL = Bundle.module.url(forResource: fileName.weeklyWeatherDetails, withExtension: fileExtension.json)
        else {
            throw(DummyError.fileNotFound)
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let items = try JSONDecoder().decode([WeeklyForecastResponse.ResponseItem].self, from: data)
            return items
        } catch {
            print(error.localizedDescription)
            throw(DummyError.invalidType)
        }
    }

    public static func dummyCurrentWeatherResponse() throws -> CurrentWeatherForecastResponse {
        guard let fileURL = Bundle.module.url(forResource: fileName.currentWeatherDetails, withExtension: fileExtension.json)
        else {
            throw(DummyError.fileNotFound)
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let items = try JSONDecoder().decode(CurrentWeatherForecastResponse.self, from: data)
            return items
        } catch {
            print(error.localizedDescription)
            throw(DummyError.invalidType)
        }
    }
}
