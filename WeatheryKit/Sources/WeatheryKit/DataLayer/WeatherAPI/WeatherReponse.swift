//
//  WeatherReponse.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import Foundation

public struct WeeklyForecastResponse: Codable {
    public let list: [ResponseItem]

    public struct ResponseItem: Codable {
        public let date: Date
        public let temperature: Temperature
        public let weather: [Weather]

        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case temperature = "main"
            case weather
        }
    }

    public struct Temperature: Codable {
        public let temp: Double
    }

    public struct Weather: Codable {
        public let weatherCondition: WeatherCondition
        public let weatherDescription: String

        enum CodingKeys: String, CodingKey {
            case weatherCondition = "main"
            case weatherDescription = "description"
        }

        public enum WeatherCondition: String, Codable {
            case clear = "Clear"
            case clouds = "Clouds"
            case rain = "Rain"
        }
    }
}

public struct CurrentWeatherForecastResponse: Decodable {
    public let coord: Coord
    public let main: Main

    public struct Main: Codable {
        public let temperature: Double
        public let humidity: Int
        public let maxTemp: Double
        public let minTemp: Double

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case humidity
            case maxTemp = "temp_max"
            case minTemp = "temp_min"
        }
    }

    public struct Coord: Codable {
        public let lon: Double
        public let lat: Double
    }
}
