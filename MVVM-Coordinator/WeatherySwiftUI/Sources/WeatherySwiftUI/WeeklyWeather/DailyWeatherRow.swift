//
//  DailyWeatherRow.swift
//  WeatherySwiftUI
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import SwiftUI
import WeatheryKit

struct DailyWeatherRow: View {
    private let viewModel: DailyWeatherDataSourceViewModel

    init(viewModel: DailyWeatherDataSourceViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            VStack {
                Text(viewModel.day)
                Text(viewModel.month)
            }

            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.body)
                Text(viewModel.fullDescription)
                    .font(.footnote)
            }
            .padding(.leading, 8)

            Spacer()

            Text("\(viewModel.temperature)°")
                .font(.title)
        }
    }
}
