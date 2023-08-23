//
//  DetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Yuliya on 17/08/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private enum CellType {
        case photoName(PhotoNameViewModel)
        case header(HeaderViewModel)
        case infoBlock(InfoViewModel)
        case originBlock(OriginViewModel)
        case episodesBlock(EpisodeViewModel)
    }
    
    private var dataManager: DataManagerProtocol?
    private let dispatchGroup = DispatchGroup()
    
    private var characterURL: String = ""
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    private let detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var allCells = [CellType]()
    private var imageUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.main
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(detailsCollectionView)
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        detailsCollectionView.register(PhotoAndNameCollectionViewCell.self,
                                       forCellWithReuseIdentifier: PhotoAndNameCollectionViewCell.identifier)
        detailsCollectionView.register(HeaderCollectionViewCell.self,
                                       forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
        detailsCollectionView.register(InfoCollectionViewCell.self,
                                       forCellWithReuseIdentifier: InfoCollectionViewCell.identifier)
        detailsCollectionView.register(OriginCollectionViewCell.self,
                                       forCellWithReuseIdentifier: OriginCollectionViewCell.identifier)
        detailsCollectionView.register(EpisodeCollectionViewCell.self,
                                       forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        
        createActivityIndicator()

        getInfoForCells()
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.detailsCollectionView.reloadData()
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createActivityIndicator() {
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        activityIndicator.style = .medium
    }
    
    @objc
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func set(characterURL: String) {
        self.characterURL = characterURL
    }
    
    func set(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
 
    private func getInfoForCells() {
        
        dispatchGroup.enter()
        dataManager?.getData(url: characterURL, completion: { [weak self] (details: DetailsModel?) in
            guard let self else { return }
            
            guard let imageUrl = details?.image else { return }
            dispatchGroup.enter()
            dataManager?.loadImage(from: imageUrl) { image in
                let photoNameCell: PhotoNameViewModel = .init(photo: image,
                                                              name: details?.name ?? "",
                                                              status: details?.status ?? "")
                self.allCells.append(.photoName(photoNameCell))
                self.dispatchGroup.leave()
            }

            guard let episodeUrl = details?.episode else { return }
            for item in episodeUrl {
                dispatchGroup.enter()
                dataManager?.getData(url: item) { (episode: EpisodeModel?) in
                    let episodeCell: EpisodeViewModel = .init(episodesName: episode?.name ?? "",
                                                              episodeAndSeasonNumber: episode?.episode ?? "",
                                                              date: episode?.airDate ?? "")
                    self.allCells.append(.episodesBlock(episodeCell))
                    self.dispatchGroup.leave()
                }
            }
            
            let infoHeaderCell: HeaderViewModel = .init(header: "Info")
            let infoCell: InfoViewModel = .init(species: details?.species ?? "",
                                                type: !(details?.type.isEmpty ?? true) ? (details?.type ?? "") : "None",
                                                gender: details?.gender ?? "")
            
            let originHeaderCell: HeaderViewModel = .init(header: "Origin")
            let originCell: OriginViewModel = .init(origin: details?.origin.name ?? "")
            
            let episodesHeaderCell: HeaderViewModel = .init(header: "Episodes")
            
            self.allCells = [.header(infoHeaderCell), .infoBlock(infoCell),
                             .header(originHeaderCell), .originBlock(originCell),
                             .header(episodesHeaderCell)]
            
            dispatchGroup.leave()
        })
    }
}

extension DetailsViewController: UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = allCells[indexPath.item]
        switch item {
        case let .photoName(model):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAndNameCollectionViewCell.identifier, for: indexPath) as? PhotoAndNameCollectionViewCell {
                cell.set(model)
                return cell
            }
        case let .header(model):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath) as? HeaderCollectionViewCell {
                cell.set(model)
                return cell
            }
        case let .infoBlock(model):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.identifier, for: indexPath) as? InfoCollectionViewCell {
                cell.set(model)
                return cell
            }
        case let .originBlock(model):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OriginCollectionViewCell.identifier, for: indexPath) as? OriginCollectionViewCell {
                cell.set(model)
                return cell
            }
        case let .episodesBlock(model):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell {
                cell.set(model)
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        let item = allCells[indexPath.item]
        switch item {
        case let .photoName(model):
            return PhotoAndNameCollectionViewCell.size(model, containerSize: frame.size)
        case let .header(model):
            return HeaderCollectionViewCell.size(model, containerSize: frame.size)
        case let .infoBlock(model):
            return InfoCollectionViewCell.size(model, containerSize: frame.size)
        case let .originBlock(model):
            return OriginCollectionViewCell.size(model, containerSize: frame.size)
        case let .episodesBlock(model):
            return EpisodeCollectionViewCell.size(model, containerSize: frame.size)
        }
    }
}
