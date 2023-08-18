//
//  HeaderCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 18/08/2023.
//

import UIKit

struct HeaderViewModel {
    let header: String
}

class HeaderCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier: String {
        return String(describing: HeaderCollectionViewCell.self)
    }

    private enum Offset: CGFloat {
        case offset = 10
    }

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .title
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = .clear
        addSubview(headerLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offset.offset.rawValue),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offset.offset.rawValue),
            headerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(_ data: HeaderViewModel) {
        headerLabel.text = data.header
    }
    
    static func size(_ data: HeaderViewModel, containerSize: CGSize) -> CGSize {
        let cellHeight: CGFloat = 20 + Offset.offset.rawValue * 2
        return .init(width: containerSize.width, height: cellHeight)
    }
}
