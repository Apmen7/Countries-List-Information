//
//  ImagesCell.swift
//  Countries List Information
//
//  Created by Armen on 15.03.2024.
//

import UIKit

class ImagesCell: UICollectionViewCell {

    static let identifier = "ImagesCell"

    let imageView = UIImageView()

    func configure() {
        self.setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func setup() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
