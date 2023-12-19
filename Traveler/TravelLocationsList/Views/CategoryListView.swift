//
//  CategoryListView.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import SwiftUI

struct CategoryListView: View {
    let catogories: [CatogoryItem]
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0..<catogories.count, id: \.self) { index in
                    let category = catogories[index]
                    CatogoryItemView(category: category, isSelected: selectedIndex == index)
                        .onTapGesture {
                            selectedIndex = index
                        }
                    
                }
            }
        }
    }
}
