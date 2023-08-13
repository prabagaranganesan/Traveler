//
//  AppEnvironment.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import Foundation

struct AppEnvironment {
    let container: DIContainer
    
    static func bootstrap() -> AppEnvironment {
        let session = configURLSession()
        let webRepositoris = configureWebRepositories(session: session)
        let interactors = configuredInteracters(webRepositories: webRepositoris)
        let diContainer = DIContainer(interactors: interactors)
        return AppEnvironment(container: diContainer)
    }
    
    private static func configURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configureWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let travelLocationsWebrepository = RealTravelLocationsWebRepository(session: session, baseURL: "https://api.unsplash.com") //TODO: should be based on app environment
        return .init(travelLocationsWebrepository: travelLocationsWebrepository)
    }
    
    private static func configuredInteracters(webRepositories: DIContainer.WebRepositories) -> DIContainer.Interacters {
        let travelLocationsInteractor = RealTravelLocationsInteractor(webRepository: webRepositories.travelLocationsWebrepository)
        return .init(travelLocationsInteractor: travelLocationsInteractor)
    }
}

extension DIContainer {
    struct WebRepositories {
        let travelLocationsWebrepository: TravelLocationsWebrepository
    }
}
