//
//  DetailsModel.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import Foundation

struct DetailsModel: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}

// MARK: - Episodes
struct EpisodeModel: Codable {
    let id: Int
    let name, airDate, episode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode
    }
}
