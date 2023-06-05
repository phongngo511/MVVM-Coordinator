//
//  WeatherFactory.swift
//  WeatherySwiftUI
//
//  Created by Phu Phong Ngo on 5/6/2023.
//

import SwiftUI
import WeatheryKit

public enum WeatherFactory {
    public static func makeWeeklyWeatherView() -> some View {
        let viewModel = WeeklyWeatherViewModel(weatherService: WeatherService())
        return WeeklyWeatherView(viewModel: viewModel)
    }

    public static func makeCurrentWeatherView(forCity city: String, weatherService: WeatherService) -> some View {
        let viewModel = CurrentWeatherViewModel(city: city, weatherService: weatherService)
        return CurrentWeatherView(viewModel: viewModel)
    }
}
