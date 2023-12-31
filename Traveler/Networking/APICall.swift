//
//  APICall.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 13/08/23.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
    var queryParam: [URLQueryItem] { get }
}


enum APIError: Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case imageDeSerialization
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageDeSerialization: return "Cannot deserialize image from Data"
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpBody = try body()
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        request.url?.append(queryItems: queryParam)
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200..<300
}
