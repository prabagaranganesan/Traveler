//
//  RealTravelLocationsWebRepository.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import Foundation

extension RealTravelLocationsWebRepository {
    enum API {
        case allLocations(query: String, page: Int)
    }
}

extension RealTravelLocationsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .allLocations:
            return "/search/photos"
        }
    }
    
    var method: String {
        switch self {
        case .allLocations:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
    
    var queryParam: [URLQueryItem] {
        var params = [URLQueryItem]()
        switch self {
        case .allLocations(let query, let page):
            params.append(URLQueryItem(name: "query", value: query))
            params.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        params.append(URLQueryItem(name: "client_id", value: "dsy8Epfyn0vHaM8U4VlR6MJpO2YLgk9g6Sn2Q_cq7r4")) //TODO: move api key to safer place
        return params
    }
}

//https://api.unsplash.com/search/photos?client_id=dsy8Epfyn0vHaM8U4VlR6MJpO2YLgk9g6Sn2Q_cq7r4&query=rare%20animals
