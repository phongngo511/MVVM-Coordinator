//
//  MVVM_CoordinatorApp.swift
//  MVVM-Coordinator
//
//  Created by Phu Phong Ngo on 1/6/2023.
//

import SwiftUI
import WeatherySwiftUI

@main
struct MVVM_CoordinatorApp: App {
    let coordinator = AppCoordinator()
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
