//
//  Characters.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import Foundation

struct CharactersData: Codable {
    let results: [CharacterModel]
}

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let image: String
    let url: String
}
