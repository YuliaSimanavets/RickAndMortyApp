//
//  SceneDelegate.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let viewController = CharactersViewController()
        let dataManager = DataManager()
        viewController.set(dataManager)
        let navController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
    }
}

