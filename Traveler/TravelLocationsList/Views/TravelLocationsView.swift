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
        VStack(alignment: .leading) {
            HeaderView(catogories: viewModel.getCatogories())
            Text("Popular Places") //TODO: move to list item view section
                .font(.title)
                .bold()
                .foregroundColor(.black)
            content
                .onAppear { self.viewModel.send(event: .onAppear) } //TODO: Add weak self
                .frame(height: 280)
            Spacer()
        }.padding(.all, 16)
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
    @ViewBuilder
    private func list(of travelLocations: [TravelLocation]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(travelLocations, id: \.self) { travelLocation in
                    NavigationLink(destination: Text(travelLocation.description ?? ""),
                                   label: { TravelLocationItemView(travelLocation: travelLocation)
                            .frame(width: UIScreen.main.bounds.width / 2.1, height: UIScreen.main.bounds.width / 1.5)
                    })
                }
            }
        }
    }
}
