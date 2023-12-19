//
//  CatogoryListItem.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import SwiftUI

struct CatogoryItem: Hashable {
    let imageName: String
    let title: String
    var isSelected: Bool
}

struct CatogoryItemView: View {
    let category: CatogoryItem
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Image(category.imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .cornerRadius(4)
            Text(category.title)
                .foregroundColor(isSelected ? .white : .black)
        }.padding(.all, 8)
        .background( isSelected ? .blue : .white)
        .cornerRadius(8)
    }
}
