//
//  CurrentWeatherView.swift
//  WeatherySwiftUI
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import SwiftUI
import WeatheryKit

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel
    var coordinator: AppCoordinatorProtocol?

    var body: some View {
        List {
            contentView()
        }
        .onAppear(perform: viewModel.reloadWeather)
        .onDisappear(perform: coordinator?.discardWeather)
        .listStyle(.grouped)
        .navigationBarTitle(viewModel.city)
    }
}

private extension CurrentWeatherView {
    func contentView() -> some View {
        if let dataSource = viewModel.dataSource {
            return AnyView(detailsView(for: dataSource))
        } else {
            return AnyView(loadingView)
        }
    }

    var loadingView: some View {
        Text("Loading \(viewModel.city)'s weather...")
            .foregroundColor(.gray)
    }

    func detailsView(for viewModel: CurrentWeatherDataSourceViewModel) -> some View {
        CurrentWeatherRow(viewModel: viewModel)
    }
}

#if DEBUG
struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(viewModel: createDummyViewModel(), coordinator: AppCoordinatorMock())
    }

    static func createDummyViewModel() -> CurrentWeatherViewModel {
        let viewModel = CurrentWeatherViewModel(city: "Sydney", weatherService: WeatherService())
        let data = try! WeatheryServiceMock.currentWeatherResponseMock()
        viewModel.dataSource = CurrentWeatherDataSourceViewModel(responseItem: data)
        return viewModel
    }
}
#endif
