//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import UIKit

class CharactersViewController: UIViewController {

    private enum Offset: CGFloat {
        case spaceOffset = 20
    }
    
    private var dataManager: DataManagerProtocol?
    private let activityIndicator = UIActivityIndicatorView()
    
    private let charactersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textColor = .title
        label.text = "Characters"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var charactersArray = [CharacterModel]()
    private var allCharacters = [CharactersViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.main
        
        view.addSubview(charactersLabel)
        view.addSubview(charactersCollectionView)
        
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        charactersCollectionView.register(CharactersCollectionViewCell.self,
                                          forCellWithReuseIdentifier: CharactersCollectionViewCell.identifier)
        
        createActivityIndicator()
        
        dataManager?.loadCharacters { [weak self] characterArray in
            guard let self else { return }
            DispatchQueue.main.async {
                self.charactersArray = characterArray
                self.activityIndicator.stopAnimating()
                self.charactersCollectionView.reloadData()
                
                self.allCharacters = characterArray.map({ CharactersViewModel(image: UIImage(systemName: ""),  //
                                                                              name: $0.name,
                                                                              url: $0.url)
                }).compactMap({ $0 })
            }
        }

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            charactersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Offset.spaceOffset.rawValue),
            charactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Offset.spaceOffset.rawValue),
            charactersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Offset.spaceOffset.rawValue),
            charactersLabel.heightAnchor.constraint(equalToConstant: Offset.spaceOffset.rawValue * 2),
            
            charactersCollectionView.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor, constant: Offset.spaceOffset.rawValue),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Offset.spaceOffset.rawValue),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Offset.spaceOffset.rawValue),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createActivityIndicator() {
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        activityIndicator.style = .medium
    }
    
    func set(_ dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    @objc
    func tapAction(by selectedIndex: IndexPath) {
        
        let characterURL = allCharacters[selectedIndex.row].url
        
        let detailsVC = DetailsViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
                
        detailsVC.set(characterURL: characterURL)
        detailsVC.set(dataManager: dataManager ?? DataManager())
    }
}

extension CharactersViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as? CharactersCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = allCharacters[indexPath.item]
        cell.set(item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        let item = allCharacters[indexPath.item]
        return CharactersCollectionViewCell.size(item, containerSize: frame.size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapAction(by: indexPath)
    }
}
