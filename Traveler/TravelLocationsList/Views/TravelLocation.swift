//
//  TravelLocations.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import Foundation

struct TravelLocation: Codable, Hashable {
    let url: String?
    let description: String?
    
    init(location: TravelLocationDTO) {
        self.url = location.urls.regular
        self.description = location.altDescription
    }
}
