//
//  WeeklyWeatherViewModel.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import Foundation
import Combine

public class WeeklyWeatherViewModel: ObservableObject {
    @Published public var city: String = ""
    @Published public var dataSource = [DailyWeatherDataSourceViewModel]()

    public let weatherService: WeatherService
    private var disposables = Set<AnyCancellable>()

    public init(weatherService: WeatherService, scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")) {
        self.weatherService = weatherService
        $city
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchWeather(forCity:))
            .store(in: &disposables)
    }

    public func fetchWeather(forCity city: String) {
        weatherService
            .weeklyWeatherForecast(forCity: city)
            .map { response in
                response.list.map{ DailyWeatherDataSourceViewModel(reponseItem: $0) }
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                        case .failure(_):
                            self.dataSource = []
                        case .finished:
                            break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.dataSource = forecast
                })
            .store(in: &disposables)
    }
}
