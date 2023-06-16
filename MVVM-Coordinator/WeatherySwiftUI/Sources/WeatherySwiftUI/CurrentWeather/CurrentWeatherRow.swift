//
//  CurrentWeatherRow.swift
//  WeatherySwiftUI
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import WeatheryUIKit
import WeatheryKit
import SwiftUI

struct CurrentWeatherRow: View {
    private var viewModel: CurrentWeatherDataSourceViewModel

    init(viewModel: CurrentWeatherDataSourceViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            MapView(coordinate: viewModel.coordinate)
                .cornerRadius(5)
                .frame(height: 250)
                .disabled(true)

            VStack(alignment: .leading) {
                HStack {
                    Text("☀️ Temperature: ")
                    Text(viewModel.temperature)
                        .foregroundColor(.gray)
                }.padding(.all, 5)
                HStack {
                    Text("📈 Max temperature:")
                    Text(viewModel.maxTemperature)
                        .foregroundColor(.gray)
                }.padding(.all, 5)
                HStack {
                    Text("📉 Min temperature:")
                    Text(viewModel.minTemperature)
                        .foregroundColor(.gray)
                }.padding(.all, 5)
                HStack {
                    Text("💧 Humidity:")
                    Text(viewModel.humidity)
                        .foregroundColor(.gray)
                }.padding(.all, 5)
            }
        }
    }
}

#if DEBUG
struct CurrentWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherRow(viewModel: createDummyViewModel())
    }

    static func createDummyViewModel() -> CurrentWeatherDataSourceViewModel {
        return CurrentWeatherDataSourceViewModel(responseItem: try! WeatheryDummyService.dummyCurrentWeatherResponse())
    }
}
#endif
