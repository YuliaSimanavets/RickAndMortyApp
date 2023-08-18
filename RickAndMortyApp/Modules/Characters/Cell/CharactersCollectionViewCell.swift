//
//  CharactersCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import UIKit

struct CharactersViewModel {
    let image: UIImage?
    let name: String
    let url: String
}

class CharactersCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier: String {
        return String(describing: CharactersCollectionViewCell.self)
    }
    
    private enum Offset: CGFloat {
        case offset = 8
    }
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    MARK: - will change
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.backgroundForCell
        layer.cornerRadius = 10
        
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offset.offset.rawValue),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offset.offset.rawValue),
            characterImageView.heightAnchor.constraint(equalToConstant: 140),
            characterImageView.widthAnchor.constraint(equalToConstant: 140),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: Offset.offset.rawValue * 2),
            characterNameLabel.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(_ data: CharactersViewModel) {
        characterImageView.image = data.image
        characterNameLabel.text = data.name
    }
    
    static func size(_ data: CharactersViewModel, containerSize: CGSize) -> CGSize {
        let cellHeight: CGFloat = 140 + 20 + Offset.offset.rawValue * 5
        return .init(width: containerSize.width / 2 - CGFloat(10), height: cellHeight)
    }
}
