//
//  CurrentWeatherDataSourceViewModel.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import MapKit

public struct CurrentWeatherDataSourceViewModel {
    private let responseItem: CurrentWeatherForecastResponse

    public init(responseItem: CurrentWeatherForecastResponse) {
        self.responseItem = responseItem
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
