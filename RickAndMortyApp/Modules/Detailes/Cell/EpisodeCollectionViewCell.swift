//
//  EpisodeCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 18/08/2023.
//

import UIKit

struct EpisodViewModel {
    let episodesName: String
    let episodeAndSeasonNumber: String
    let date: String
}

class EpisodeCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier: String {
        return String(describing: EpisodeCollectionViewCell.self)
    }

    private enum Offset: CGFloat {
        case offset = 10
    }
    
    private let episodesNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .title
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeAndSeasonNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .green
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .subtitle
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = .backgroundForCell
        layer.cornerRadius = 10
        addSubview(episodesNameLabel)
        addSubview(episodeAndSeasonNumberLabel)
        addSubview(dateLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            episodesNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Offset.offset.rawValue * 2),
            episodesNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offset.offset.rawValue * 2),
            episodesNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Offset.offset.rawValue * 2),
            episodesNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            episodeAndSeasonNumberLabel.topAnchor.constraint(equalTo: episodesNameLabel.bottomAnchor, constant: Offset.offset.rawValue * 2),
            episodeAndSeasonNumberLabel.leadingAnchor.constraint(equalTo: episodesNameLabel.leadingAnchor),
            episodeAndSeasonNumberLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -Offset.offset.rawValue),
            episodeAndSeasonNumberLabel.heightAnchor.constraint(equalToConstant: 15),
            episodeAndSeasonNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Offset.offset.rawValue * 2),
            
            dateLabel.topAnchor.constraint(equalTo: episodeAndSeasonNumberLabel.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: episodesNameLabel.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: Offset.offset.rawValue),
            dateLabel.bottomAnchor.constraint(equalTo: episodeAndSeasonNumberLabel.bottomAnchor)
        ])
    }
    
    func set(_ data: EpisodViewModel) {
        episodesNameLabel.text = data.episodesName
        dateLabel.text = data.date
        episodeAndSeasonNumberLabel.text = data.episodeAndSeasonNumber
    }
    
    static func size(_ data: EpisodViewModel, containerSize: CGSize) -> CGSize {
        let cellHeight: CGFloat = 20 + 15 + Offset.offset.rawValue * 6
        return .init(width: containerSize.width, height: cellHeight)
    }
}
