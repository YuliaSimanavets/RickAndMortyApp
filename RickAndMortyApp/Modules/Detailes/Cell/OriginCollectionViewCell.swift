//
//  OriginCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 18/08/2023.
//

import UIKit

struct OriginViewModel {
    let origin: String
}

class OriginCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier: String {
        return String(describing: OriginCollectionViewCell.self)
    }

    private enum Offset: CGFloat {
        case offset = 10
    }
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let planetView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "planet")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .title
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let planetLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.text = "Planet"
        label.textColor = .green
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = .backgroundForCell
        layer.cornerRadius = 10
        addSubview(backView)
        addSubview(planetView)
        addSubview(originLabel)
        addSubview(planetLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offset.offset.rawValue),
            backView.heightAnchor.constraint(equalToConstant: 64),
            backView.widthAnchor.constraint(equalToConstant: 64),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Offset.offset.rawValue),
            
            planetView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            planetView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            planetView.heightAnchor.constraint(equalToConstant: 24),
            planetView.widthAnchor.constraint(equalToConstant: 24),
            
            originLabel.bottomAnchor.constraint(equalTo: backView.centerYAnchor, constant: -5),
            originLabel.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: Offset.offset.rawValue * 2),
            originLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offset.offset.rawValue * 2),
            originLabel.heightAnchor.constraint(equalToConstant: 20),
            
            planetLabel.topAnchor.constraint(equalTo: backView.centerYAnchor, constant: 5),
            planetLabel.leadingAnchor.constraint(equalTo: originLabel.leadingAnchor),
            planetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offset.offset.rawValue),
            planetLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func set(_ data: OriginViewModel) {
        originLabel.text = data.origin
    }
    
    static func size(_ data: OriginViewModel, containerSize: CGSize) -> CGSize {
        let cellHeight: CGFloat = 64 + Offset.offset.rawValue * 2
        return .init(width: containerSize.width, height: cellHeight)
    }
}
