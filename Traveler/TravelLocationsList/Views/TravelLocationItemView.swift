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
        VStack() {
            poster
            title
        }
    }
    
    @ViewBuilder
    private var title: some View {
        Text(travelLocation.description ?? "")
            .font(.headline)
            .lineLimit(1)
            .foregroundColor(.black)
            .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private var poster: some View {
        travelLocation.url.map { url in
            AsyncImage(url: URL(string: url)! , cache: cache, placeHolder: spinner, configuration: { $0.resizable().renderingMode(.original) })
                .frame(width: 190, height: 230) //TODO: give dynamic size
                .cornerRadius(16)
                
        }
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}
