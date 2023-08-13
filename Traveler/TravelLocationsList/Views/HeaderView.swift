//
//  HeaderView.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import SwiftUI

struct HeaderView: View {
    let catogories: [CatogoryItem]
    @State var text: String = ""

    var body: some View {
        VStack {
            HStack {
                Button {
                    print("Coming Soon") //TODO: add localised key
                } label: {
                    Image("left_menu")
                        .resizable()
                }.frame(width: 33, height: 33)
                Spacer()
                
                Button {
                    print("Coming Soon") //TODO: add localised key
                } label: {
                    Image("sample_profile")
                        .resizable()
                }.frame(width: 50, height: 50)
            }
            
            HStack {
                Text("Experience the \nWorld!") //TODO: add localised key
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                Spacer()
            }
            SearchBar(text: $text)
            CategoryListView(catogories: catogories)
                .frame(height: 70)

        }
        
    }
}
