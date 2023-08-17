//
//  DetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private var dataManager: DataManagerProtocol?
    private var characterURL: String = ""
    
    private let activityIndicator = UIActivityIndicatorView()
    
    private let charactersIdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.backgroundColor = .systemYellow
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        view.addSubview(charactersIdLabel)
        
        createActivityIndicator()
        
        dataManager?.getDetails(url: characterURL, completion: { [weak self] characterDetailsArray in
            guard let self else { return }
            
            
        })
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            charactersIdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charactersIdLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            charactersIdLabel.heightAnchor.constraint(equalToConstant: 100),
            charactersIdLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func createActivityIndicator() {
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        activityIndicator.style = .medium
    }
    
    
    
    func set(characterURL: String) {
        self.characterURL = characterURL
        charactersIdLabel.text = characterURL
    }
    
    func set(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
}
