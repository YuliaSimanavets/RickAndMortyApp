//
//  DataManager.swift
//  PokemonApplication
//
//  Created by Yuliya on 12/04/2023.
//

import Foundation
import UIKit

protocol DataManagerProtocol {
    func loadCharacters(dataCollected: @escaping ([CharacterModel]) -> ())
    func getDetails(url: String, completion: @escaping (DetailsModel?) -> ())
}

final class DataManager: DataManagerProtocol {

    var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        return components
    }()
    
    func loadCharacters(dataCollected: @escaping ([CharacterModel]) -> ()) {

        components.path = "/api/character"
        guard let url = components.url?.absoluteString else { return }
        let request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("error")
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let responseData = data {
                let characterData = try? JSONDecoder().decode(CharactersData.self, from: responseData)
                DispatchQueue.main.async {
                    dataCollected(characterData?.results ?? [])
                }
            }
        }
        task.resume()
    }
    
    func getDetails(url: String, completion: @escaping (DetailsModel?) -> ()) {

        guard let url = components.url?.absoluteString else { return }
        let request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("error")
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let responseData = data {
                let detailsData = try? JSONDecoder().decode(DetailsModel.self, from: responseData)
                DispatchQueue.main.async {
                    completion(detailsData)
                }
            }
        }
        task.resume()
    }
}