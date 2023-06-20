//
//  WeeklyWeatherView.swift
//  WeatherySwiftUI
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import SwiftUI
import WeatheryKit

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    var coordinator: AppCoordinatorProtocol

    var body: some View {
        NavigationView {
            Form {
                searchField
                if viewModel.dataSource.isEmpty {
                    emptySectionView
                } else {
                    cityHourlyWeatherSectionView
                    forecastSectionView
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("Today's Weather")
        }
    }
}

private extension WeeklyWeatherView {
    var searchField: some View {
        Section("Search for City name") {
            HStack(alignment: .center) {
                TextField("e.g. Sydney", text: $viewModel.city)
            }
        }
    }

    var forecastSectionView: some View {
        Section("Forecast") {
            HStack {
                Image(systemName: "calendar")
                Text("Weekdays' Forecast")
            }
            ForEach(viewModel.dataSource) { dataSourceViewModel in
                DailyWeatherRow(viewModel: dataSourceViewModel)
            }
        }
    }

    var cityHourlyWeatherSectionView: some View {
        Section("Today's weather") {
            NavigationLink(destination: coordinator.showCurrentWeather(with: viewModel.city)) {
                VStack(alignment: .leading) {
                    Text(viewModel.city)
                    Text("See more")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    var emptySectionView: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}

#if DEBUG
struct WeeklyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyWeatherView(viewModel: createDummyViewModel(), coordinator: AppCoordinatorMock())
    }

    static func createDummyViewModel() -> WeeklyWeatherViewModel {
        let viewModel = WeeklyWeatherViewModel(weatherService: WeatherService())
        let data: [DailyWeatherDataSourceViewModel] = try! WeatheryServiceMock.weaklyWeatherResponseMock().compactMap { DailyWeatherDataSourceViewModel(reponseItem: $0)}
        viewModel.city = "Sydney"
        viewModel.dataSource = data
        return viewModel
    }
}
#endif
