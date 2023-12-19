//
//  TravelLocationsViewModelState.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import Foundation

extension TravelLocationsViewModel {
    enum State {
        case idle
        case loading
        case loaded([TravelLocation])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case next
        case onSelectLocation(Int)
        case onTravelLocationLoaded([TravelLocation])
        case onfailedtoLoadLocations(Error)
    }
}
