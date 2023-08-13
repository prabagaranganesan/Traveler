//
//  RealTravelLocationsInteractor.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import Combine
import Foundation
import SwiftUI

protocol TravelLocationsInteractor {
    func load(search: String) -> AnyPublisher<[TravelLocationDTO], Error>
}

struct RealTravelLocationsInteractor: TravelLocationsInteractor {
    private let webRepository: TravelLocationsWebrepository

    init(webRepository: TravelLocationsWebrepository) {
        self.webRepository = webRepository
    }
        
    func load(search: String) -> AnyPublisher<[TravelLocationDTO], Error> {
        return webRepository.loadTravelLocations(queryText: search)
            .map { response in
                return response.results
            }
            .eraseToAnyPublisher()
    }
}

extension Just where Output == Void {
    static func withErrorType<E>(_ errorType: E.Type) -> AnyPublisher<Void, E> {
        return withErrorType((), E.self)
    }
    
    static func withErrorType<E>(_ value: Output, _ errorTyoe: E.Type) -> AnyPublisher<Output, E> {
        return Just(value)
            .setFailureType(to: E.self)
            .eraseToAnyPublisher()
    }
}
