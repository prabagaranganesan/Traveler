//
//  TravelLocationsView.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import Foundation
import SwiftUI

struct TravelLocationsView: View {
    @ObservedObject var viewModel: TravelLocationsViewModel
    
    init(viewModel: TravelLocationsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Trending places") //TODO: add localised key
        }
        .onAppear { self.viewModel.send(event: .onAppear) }
        
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .loading:
            Spinner(isAnimating: true, style: .large)
        case .error(let error):
            Text(error.localizedDescription)
        case .loaded(let travelLocations):
            list(of: travelLocations)
        }
    }
    
    private func list(of travelLocations: [TravelLocation]) -> some View {
        return List(travelLocations, id: \.self) { travelLocation in
            NavigationLink(destination: Text(""),
                           label: { TravelLocationItemView(travelLocation: travelLocation) })

        }
    }
}
