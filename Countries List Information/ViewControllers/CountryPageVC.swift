//
//  CountryPageVC.swift
//  Countries List Information
//
//  Created by Armen on 03.02.2024.
//

import UIKit

final class CountryPageVC: UIViewController {

    private var images: [UIImage] = []
    private let countryName = UILabel()
    private let countryCapital = UILabel()
    private let countryDescription = UILabel()
    var countries: [Country] = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)

        return collectionView
    }()

    override func viewDidLoad() {
        setupUI()

        for _ in 0...25 {
            images.append(UIImage(named: "1")!)
            images.append(UIImage(named: "2")!)
            images.append(UIImage(named: "3")!)
            images.append(UIImage(named: "4")!)
            images.append(UIImage(named: "5")!)
        }

        self.collectionView.dataSource = self
    }

    func configure(with country: Country) {
        countryName.text = country.name
        countryCapital.text = country.capital
        countryDescription.text = country.description
    }

    func setupUI() {
        view.backgroundColor = .systemTeal
        setupCollectionView()
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])
    }
}

extension CountryPageVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier, for: indexPath) as? ImagesCollectionViewCell else {
            return UICollectionViewCell()
        }

        let image = self.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
}
