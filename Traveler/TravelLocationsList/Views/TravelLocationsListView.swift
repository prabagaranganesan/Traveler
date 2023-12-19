//
//  TravelLocationsListView.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 15/08/23.
//

import SwiftUI

struct TravelLocationListView: View {
    @Binding var travelLocations: [TravelLocation]
    let nextPageHandler: () -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(travelLocations, id: \.self) { traveLocation in
                    NavigationLink(destination: Text(traveLocation.description ?? ""),
                                   label: { TravelLocationItemView(travelLocation: traveLocation)
                                                .frame(width: UIScreen.main.bounds.width / 2.1, height: UIScreen.main.bounds.width / 1.5)
                                                .task {
                                                    if travelLocations.last == traveLocation  {
                                                        nextPageHandler()
                                                    }
                                                }
                                    })
                }
            }
        }
    }
}
