//
//  PhotoAndNameCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 18/08/2023.
//

import UIKit

struct PhotoNameViewModel {
    let photo: UIImage?
    let name: String
    let status: String
}

class PhotoAndNameCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier: String {
        return String(describing: PhotoAndNameCollectionViewCell.self)
    }

    private enum Offset: CGFloat {
        case offset = 10
    }
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = .title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .green
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = .clear
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        addSubview(characterStatusLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue),
            characterImageView.heightAnchor.constraint(equalToConstant: 148),
            characterImageView.widthAnchor.constraint(equalToConstant: 148),

            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: Offset.offset.rawValue * 2),
            characterNameLabel.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: Offset.offset.rawValue),
            characterStatusLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            characterStatusLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            characterStatusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(_ data: PhotoNameViewModel) {
        characterImageView.image = data.photo
        characterNameLabel.text = data.name
        characterStatusLabel.text = data.status
    }
    
    static func size(_ data: PhotoNameViewModel, containerSize: CGSize) -> CGSize {
        let cellHeight: CGFloat = 148 + 25 + 20 + Offset.offset.rawValue * 5
        return .init(width: containerSize.width, height: cellHeight)
    }
}
