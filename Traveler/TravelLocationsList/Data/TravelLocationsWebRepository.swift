//
//  TravelLocationsWebRepository.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import Combine
import Foundation

protocol TravelLocationsWebrepository: WebRepository {
    func loadTravelLocations(queryText: String, page: Int) -> AnyPublisher<PageDTO<TravelLocationDTO>, Error>
}

struct RealTravelLocationsWebRepository: TravelLocationsWebrepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadTravelLocations(queryText: String, page: Int) -> AnyPublisher<PageDTO<TravelLocationDTO>, Error> {
        return call(endpoint: API.allLocations(query: queryText, page: page))
    }
}
