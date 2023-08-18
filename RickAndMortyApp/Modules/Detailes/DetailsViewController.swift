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
        case info(InfoViewModel)
    }
    
    private var dataManager: DataManagerProtocol?
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
//        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var allCells = [CellType]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        getFavourites()
        detailsCollectionView.reloadData()
    }
    
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
        
        createActivityIndicator()
        
//        dataManager?.getDetails(url: characterURL, completion: { [weak self] characterDetails in
//            guard let self else { return }
//
//
//        })
        createAllCells()
        print("\(allCells.count)")
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

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
    
    private func createAllCells() {
        let photoNameCell: PhotoNameViewModel = .init(photo: UIImage(systemName: "house"), name: "Rick", status: "Alive")
        let headerCell: HeaderViewModel = .init(header: "Info")
        let infoCell: InfoViewModel = .init(species: "Human", type: "None", gender: "Male")
        
        allCells = [.photoName(photoNameCell), .header(headerCell), .info(infoCell)]
        detailsCollectionView.reloadData()
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
        case let .info(model):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.identifier, for: indexPath) as? InfoCollectionViewCell {
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
        case let .info(model):
            return InfoCollectionViewCell.size(model, containerSize: frame.size)
        }
    }
}
