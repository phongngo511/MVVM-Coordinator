//
//  DailyWeatherDataSourceViewModel.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import Foundation

public struct DailyWeatherDataSourceViewModel: Identifiable {
    private let reponseItem: WeeklyForecastResponse.ResponseItem

    public init(reponseItem: WeeklyForecastResponse.ResponseItem) {
        self.reponseItem = reponseItem
    }

    public var id: String {
        return day + temperature + title
    }

    public var day: String {
        return DateTimeFormatter.dayFormatter.string(from: reponseItem.date)
    }

    public var month: String {
        return DateTimeFormatter.monthFormatter.string(from: reponseItem.date)
    }

    public var temperature: String {
        return reponseItem.temperature.temp.toString() ?? ""
    }

    public var title: String {
        return reponseItem.weather.first?.weatherCondition.rawValue ?? ""
    }

    public var fullDescription: String {
        return reponseItem.weather.first?.weatherDescription ?? ""
    }
}

extension DailyWeatherDataSourceViewModel: Hashable {
    public static func == (lhs: DailyWeatherDataSourceViewModel, rhs: DailyWeatherDataSourceViewModel) -> Bool {
        return lhs.day == rhs.day
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.day)
    }
}
