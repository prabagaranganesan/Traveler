//
//  TravelLocationItemView.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import Foundation
import SwiftUI

struct TravelLocationItemView: View {
    let travelLocation: TravelLocation
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            poster
        }
    }
    
    @ViewBuilder
    private var title: some View {
        Text(travelLocation.description ?? "")
            .font(.subheadline)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder
    private var poster: some View {
        travelLocation.url.map { url in
            AsyncImage(url: URL(string: url)! , cache: cache, placeHolder: spinner, configuration: { $0.resizable().renderingMode(.original) })
                .aspectRatio(contentMode: .fit)
        }
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}
