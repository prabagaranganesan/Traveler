//
//  TravelLocationDTO.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import Foundation

struct TravelLocationDTO: Codable {
    let urls: URLModel
    let altDescription: String?
    
    struct URLModel: Codable {
        let regular: String?
        let small: String?
        let full: String?
        let thumb: String?
    }
}

struct PageDTO<T: Codable>: Codable {
    let page: Int?
    let totalResult: Int?
    let totalPages: Int?
    let results: [T]
}
