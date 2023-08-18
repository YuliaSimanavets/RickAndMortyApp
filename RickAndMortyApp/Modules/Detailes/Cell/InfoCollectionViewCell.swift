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
    }

    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Offset.offset.rawValue
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Offset.offset.rawValue
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let speciesDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = .backgroundForCell
        addSubview(speciesLabel)
        setupInfoStackView()
        
        setupConstraints()
    }
    
    private func setupInfoStackView() {
        addSubview(infoStackView)
        infoStackView.addSubview(speciesLabel)
        infoStackView.addSubview(typeLabel)
        infoStackView.addSubview(genderLabel)
    }

    private func setupInfoDataStackView() {
        addSubview(infoDataStackView)
        infoDataStackView.addSubview(speciesDataLabel)
        infoDataStackView.addSubview(typeDataLabel)
        infoDataStackView.addSubview(genderDataLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offset.offset.rawValue),
            infoStackView.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            infoDataStackView.centerYAnchor.constraint(equalTo: infoStackView.centerYAnchor),
//            infoDataStackView.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue)
            infoDataStackView.leadingAnchor.constraint(equalTo: centerXAnchor),
            infoDataStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offset.offset.rawValue)
        ])
    }
    
    func set(_ data: InfoViewModel) {
        speciesDataLabel.text = data.species
        typeDataLabel.text = data.type
        genderDataLabel.text = data.gender
    }
    
    static func size(_ data: InfoViewModel, containerSize: CGSize) -> CGSize {
        let cellHeight: CGFloat = 100
        return .init(width: containerSize.width, height: cellHeight)
    }
}
