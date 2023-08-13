//
//  SearchBar.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 28
        searchBar.clipsToBounds = true
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.placeholder = "Search coffee favorite" // TODO: update loclise key
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
}

extension SearchBar {
    final class Coordinator: NSObject, UISearchBarDelegate {
        
        let text: Binding<String>
        
        init(text: Binding<String>) {
            self.text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text.wrappedValue = searchText
        }
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }
        
        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            searchBar.text = ""
            text.wrappedValue = ""
        }
    }
}

struct ProductSearch {
    var searchText: String = ""
    var keyboardHeight: CGFloat = 0
}
