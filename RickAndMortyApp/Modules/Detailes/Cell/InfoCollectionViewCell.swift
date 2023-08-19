//
//  InfoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 18/08/2023.
//

import UIKit

struct InfoViewModel {
    let species: String
    let type: String
    let gender: String
}

class InfoCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier: String {
        return String(describing: InfoCollectionViewCell.self)
    }

    private enum Offset: CGFloat {
        case offset = 10
        case textHeight = 20
    }

    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "Speicies:"
        label.textColor = .title
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "Type:"
        label.textColor = .title
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "Gender:"
        label.textColor = .title
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let speciesDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .title
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .title
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .title
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = .backgroundForCell
        layer.cornerRadius = 10
        
        addSubview(speciesLabel)
        addSubview(typeLabel)
        addSubview(genderLabel)
        addSubview(speciesDataLabel)
        addSubview(typeDataLabel)
        addSubview(genderDataLabel)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue * 2),
            speciesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offset.offset.rawValue * 2),
            speciesLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -Offset.offset.rawValue),
            speciesLabel.heightAnchor.constraint(equalToConstant: Offset.textHeight.rawValue),
            
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: Offset.offset.rawValue),
            typeLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: speciesLabel.trailingAnchor),
            typeLabel.heightAnchor.constraint(equalToConstant: Offset.textHeight.rawValue),
            
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: Offset.offset.rawValue),
            genderLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: speciesLabel.trailingAnchor),
            genderLabel.heightAnchor.constraint(equalToConstant: Offset.textHeight.rawValue),
            
            speciesDataLabel.centerYAnchor.constraint(equalTo: speciesLabel.centerYAnchor),
            speciesDataLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: Offset.offset.rawValue),
            speciesDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offset.offset.rawValue * 2),
            speciesDataLabel.heightAnchor.constraint(equalToConstant: Offset.textHeight.rawValue),
            
            typeDataLabel.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor),
            typeDataLabel.leadingAnchor.constraint(equalTo: speciesDataLabel.leadingAnchor),
            typeDataLabel.trailingAnchor.constraint(equalTo: speciesDataLabel.trailingAnchor),
            typeDataLabel.heightAnchor.constraint(equalToConstant: Offset.textHeight.rawValue),
            
            genderDataLabel.centerYAnchor.constraint(equalTo: genderLabel.centerYAnchor),
            genderDataLabel.leadingAnchor.constraint(equalTo: speciesDataLabel.leadingAnchor),
            genderDataLabel.trailingAnchor.constraint(equalTo: speciesDataLabel.trailingAnchor),
            genderDataLabel.heightAnchor.constraint(equalToConstant: Offset.textHeight.rawValue)
        ])
    }

    func set(_ data: InfoViewModel) {
        speciesDataLabel.text = data.species
        typeDataLabel.text = data.type
        genderDataLabel.text = data.gender
    }
    
    static func size(_ data: InfoViewModel, containerSize: CGSize) -> CGSize {
        let cellHeight: CGFloat = Offset.textHeight.rawValue * 3 + Offset.offset.rawValue * 6
        return .init(width: containerSize.width, height: cellHeight)
    }
}
