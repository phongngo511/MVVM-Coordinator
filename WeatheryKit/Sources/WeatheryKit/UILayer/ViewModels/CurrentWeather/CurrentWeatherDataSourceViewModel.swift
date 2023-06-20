//
//  CurrentWeatherDataSourceViewModel.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import MapKit

public struct CurrentWeatherDataSourceViewModel: Identifiable {
    private let responseItem: CurrentWeatherForecastResponse

    public init(responseItem: CurrentWeatherForecastResponse) {
        self.responseItem = responseItem
    }

    public var id: String {
        return coordinate.latitude.string + coordinate.longitude.string
    }

    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: responseItem.coord.lat, longitude: responseItem.coord.lon)
    }

    public var temperature: String {
        return responseItem.main.temperature.string
    }

    public var maxTemperature: String {
        return responseItem.main.maxTemp.string
    }

    public var minTemperature: String {
        return responseItem.main.minTemp.string
    }

    public var humidity: String {
        return responseItem.main.humidity.string
    }
}

extension CurrentWeatherDataSourceViewModel: Hashable {
    public static func == (lhs: CurrentWeatherDataSourceViewModel, rhs: CurrentWeatherDataSourceViewModel) -> Bool {
        return lhs.responseItem.coord.lat == rhs.responseItem.coord.lat &&
            lhs.responseItem.coord.lon == rhs.responseItem.coord.lon
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.responseItem.coord.lat)
        hasher.combine(self.responseItem.coord.lon)
    }
}
