//
//  TravelerApp.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import SwiftUI

@main
struct TravelerApp: App {
    let container = AppEnvironment.bootstrap().container

    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
        }
    }
}
