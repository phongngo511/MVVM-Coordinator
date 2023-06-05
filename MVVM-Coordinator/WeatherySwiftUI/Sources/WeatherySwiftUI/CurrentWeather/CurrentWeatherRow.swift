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
                .cornerRadius(25)
                .frame(height: 300)
                .disabled(true)

            VStack(alignment: .leading) {
                HStack {
                    Text("☀️ Temperature: ")
                    Text(viewModel.temperature)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("📈 Max temperature:")
                    Text(viewModel.maxTemperature)
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("📉 Min temperature:")
                    Text(viewModel.minTemperature)
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("💧 Humidity:")
                    Text(viewModel.humidity)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
