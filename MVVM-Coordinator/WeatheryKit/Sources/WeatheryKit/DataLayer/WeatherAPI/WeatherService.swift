//
//  WeatherService.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import Foundation
import Combine

public protocol WeatherServiceProtocol {
    func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
}

public class WeatherService {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }
}

extension WeatherService: WeatherServiceProtocol {
    public func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
        return forecast(with: makeCurrentForecastComponents(forCity: city))
    }

    public func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        return forecast(with: makeWeeklyForecastComponents(forCity: city))
    }

    private func forecast<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: WeatherErrorDescription.invalidURL.rawValue)
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: URLRequest(url: url))
            .map(\.data)
            .decode()
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

private extension WeatherService {
    struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "<your-key>"
        static let forecastPath = "/forecast"
        static let weatherPath = "/weather"
    }

    func makeWeeklyForecastComponents(forCity city: String) -> URLComponents {
        return sharedComponents(forCity: city, withSubPath: OpenWeatherAPI.forecastPath)
    }

    func makeCurrentForecastComponents(forCity city: String) -> URLComponents {
        return sharedComponents(forCity: city, withSubPath: OpenWeatherAPI.weatherPath)
    }

    private func sharedComponents(forCity city: String, withSubPath subpath: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + subpath
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        return components
    }
}
