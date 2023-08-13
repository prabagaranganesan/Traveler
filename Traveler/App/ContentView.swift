//
//  ContentView.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import SwiftUI

struct ContentView: View {
    
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        TravelLocationsView(viewModel: TravelLocationsViewModel(container: container))
    }
}
