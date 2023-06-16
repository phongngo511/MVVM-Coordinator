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

    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }

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
            NavigationLink(destination: viewModel.currentWeatherView) {
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

extension WeeklyWeatherViewModel {
    var currentWeatherView: some View {
        return WeatherFactory.makeCurrentWeatherView(forCity: city, weatherService: weatherService)
    }
}

#if DEBUG
struct WeeklyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyWeatherView(viewModel: createDummyViewModel())
    }

    static func createDummyViewModel() -> WeeklyWeatherViewModel {
        let viewModel = WeeklyWeatherViewModel(weatherService: WeatherService())
        let data: [DailyWeatherDataSourceViewModel] = try! WeatheryDummyService.dummyWeaklyWeatherResponse().compactMap { DailyWeatherDataSourceViewModel(reponseItem: $0)}
        viewModel.city = "Sydney"
        viewModel.dataSource = data
        return viewModel
    }
}
#endif
