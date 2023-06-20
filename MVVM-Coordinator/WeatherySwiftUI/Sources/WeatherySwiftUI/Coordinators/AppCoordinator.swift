//
//  AppCoordinator.swift
//  WeatherySwiftUI
//
//  Created by Phu Phong Ngo on 16/6/2023.
//

import SwiftUI
import WeatheryKit

protocol AppCoordinatorProtocol: AnyObject {
    func showCurrentWeather(with city: String) -> AnyView
    func discardWeather()
}

public final class AppCoordinator: Coordinator {
    enum AppScene: CaseIterable {
        case weekly
        case current
    }

    var scenes = [AppScene]()

    public override init() {
        super.init()
        self.scenes = []
    }
}

extension AppCoordinator: CoordinatorProtocol {
    public func start() -> some View {
        makeWeeklyWeatherView()
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func discardWeather() {
        scenes.removeLast()
    }

    func showCurrentWeather(with city: String) -> AnyView {
        AnyView(makeCurrentWeatherView(forCity: city))
    }
}

private extension AppCoordinator {
    var weatherService: WeatherService {
        return WeatherService()
    }

    func makeWeeklyWeatherView() -> some View {
        scenes.append(.weekly)
        return WeeklyWeatherView(viewModel: WeeklyWeatherViewModel(weatherService: weatherService), coordinator: self)
    }

    func makeCurrentWeatherView(forCity city: String) -> some View {
        scenes.append(.current)
        return CurrentWeatherView(viewModel: CurrentWeatherViewModel(city: city, weatherService: weatherService), coordinator: self)
    }
}


#if DEBUG
class AppCoordinatorMock: AppCoordinatorProtocol {
    func discardWeather() {}

    func showCurrentWeather(with city: String) -> AnyView {
        AnyView(CurrentWeatherView(viewModel: CurrentWeatherViewModel(city: "Sydney", weatherService: WeatherService()), coordinator: self))
    }
}
#endif
