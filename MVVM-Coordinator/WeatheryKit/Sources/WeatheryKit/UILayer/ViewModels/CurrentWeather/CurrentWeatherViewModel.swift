//
//  CurrentWeatherViewModel.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import Foundation
import Combine

public class CurrentWeatherViewModel: ObservableObject {
    @Published public var dataSource: CurrentWeatherDataSourceViewModel?

    public let city: String
    private let weatherService: WeatherService
    private var disposables = Set<AnyCancellable>()

    public init(city: String, weatherService: WeatherService) {
        self.city = city
        self.weatherService = weatherService
    }

    public func reloadWeather() {
        weatherService
            .currentWeatherForecast(forCity: city)
            .map(CurrentWeatherDataSourceViewModel.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                    case .failure(let error):
                        self.dataSource = nil
                        print("Something went wrong: \(error.localizedDescription)")
                    case .finished:
                        print("Received Completion")
                        break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else { return }
                self.dataSource = weather
            })
            .store(in: &disposables)
    }
}
