//
//  AsyncImage.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeHolder: Placeholder?
    private let configuration: (Image) -> Image
    
    init(url: URL, cache: ImageCache? = nil, placeHolder: Placeholder? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        self.placeHolder = placeHolder
        self.configuration = configuration
        self.loader = ImageLoader(url: url, cache: cache)
    }
    
    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!))
            } else {
                placeHolder
            }
        }
    }
}
