//
//  ImagesCollectionViewCell.swift
//  Countries List Information
//
//  Created by Armen on 03.02.2024.
//

import UIKit

final class ImagesCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImagesCollectionViewCell"

    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .white
        imageView.clipsToBounds = true

        return imageView
    }()

    func configure(with image: UIImage) {
        self.myImageView.image = image
        self.setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
    }
}

private extension ImagesCollectionViewCell {

    func setupUI() {
        self.backgroundColor = .systemRed

        self.addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor),
            myImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
