//
//  DataManager.swift
//  PokemonApplication
//
//  Created by Yuliya on 12/04/2023.
//

import Foundation
import UIKit

protocol DataManagerProtocol {
    func loadCharacters(completion: @escaping ([CharacterModel]) -> ())
    func getData<T: Decodable>(url: String, completion: @escaping (T?) -> ())
}

final class DataManager: DataManagerProtocol {

    var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        return components
    }()
    
    func loadCharacters(completion: @escaping ([CharacterModel]) -> ()) {

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
                    completion(characterData?.results ?? [])
                }
            }
        }
        task.resume()
    }
    
    func getData<T: Decodable>(url: String, completion: @escaping (T?) -> ()) {

        let request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("error")
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let responseData = data {
                let detailsData = try? JSONDecoder().decode(T.self, from: responseData)
                DispatchQueue.main.async {
                    completion(detailsData)
                }
            }
        }
        task.resume()
    }
}
