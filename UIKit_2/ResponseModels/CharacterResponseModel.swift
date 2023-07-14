//
//  CharacterResponseModel.swift
//  UIKit_2
//
//  Created by Kamil on 11.07.2023.
//

import Foundation

// MARK: - CharacterResponseModel
struct CharacterResponseModel: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let episode: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type
        case gender, origin, location
        case episode, url, created
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
