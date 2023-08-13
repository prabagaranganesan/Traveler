//
//  CategoryListView.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import SwiftUI

struct CategoryListView: View {
    let catogories: [CatogoryItem]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(catogories, id: \.self) { catogory in
                    CatogoryItemView(category: catogory)
                }
            }
        }
    }
}
