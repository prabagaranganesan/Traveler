//
//  DIContainer.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import Foundation
import Combine
import SwiftUI

struct DIContainer: EnvironmentKey {
    static var defaultValue: Self { Self.default }
    let interacters: Interacters
    
    init(interactors: Interacters) {
        self.interacters = interactors
    }
    
    private static let `default` = Self(interactors: .stub)
    
}

extension DIContainer {
    struct Interacters {
        let travelLocationsInteractor: TravelLocationsInteractor
        
        init(travelLocationsInteractor: TravelLocationsInteractor) {
            self.travelLocationsInteractor = travelLocationsInteractor
        }
        
        static var stub: Self {
            .init(travelLocationsInteractor: StubTravelLocationsInteractor())
        }
    }
}

struct StubTravelLocationsInteractor: TravelLocationsInteractor {
    func load(search: String, page: Int) -> AnyPublisher<[TravelLocationDTO], Error> {
        return Empty().eraseToAnyPublisher()
    }
}

