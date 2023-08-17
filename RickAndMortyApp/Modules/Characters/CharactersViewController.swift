//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import UIKit

enum Offset: CGFloat {
    case generalOffset = 20
}

class CharactersViewController: UIViewController {

    private let charactersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textColor = .white
        label.text = "Characters"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
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
        // MARK: - will change
        allCharacters = [
            .init(image: UIImage(systemName: ""), name: "Rick"),
            .init(image: UIImage(systemName: ""), name: "Morty")
        ]
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            charactersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Offset.generalOffset.rawValue),
            charactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Offset.generalOffset.rawValue),
            charactersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Offset.generalOffset.rawValue),
            charactersLabel.heightAnchor.constraint(equalToConstant: Offset.generalOffset.rawValue * 2),
            
            charactersCollectionView.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor, constant: Offset.generalOffset.rawValue),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Offset.generalOffset.rawValue),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Offset.generalOffset.rawValue),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
}
