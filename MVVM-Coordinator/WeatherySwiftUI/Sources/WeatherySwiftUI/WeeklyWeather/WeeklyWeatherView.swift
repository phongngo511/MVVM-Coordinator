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
            List {
                searchField
                if viewModel.dataSource.isEmpty {
                    emptySectionView
                } else {
                    cityHourlyWeatherSectionView
                    forecastSectionView
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("Weather ⛅️")
        }
    }
}

private extension WeeklyWeatherView {
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("e.g. Sydney", text: $viewModel.city)
        }
    }

    var forecastSectionView: some View {
        Section {
            ForEach(viewModel.dataSource) { dataSourceViewModel in
                DailyWeatherRow(viewModel: dataSourceViewModel)
            }
        }
    }

    var cityHourlyWeatherSectionView: some View {
        Section {
            NavigationLink(destination: viewModel.currentWeatherView) {
                VStack(alignment: .leading) {
                    Text(viewModel.city)
                    Text("Weather today")
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

