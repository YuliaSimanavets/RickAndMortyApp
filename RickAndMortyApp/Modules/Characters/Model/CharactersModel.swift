//
//  CharactersModel.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import Foundation

// MARK: - CharactersModel
struct CharactersModel: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name: String
    let image: String
    let url: String
}
