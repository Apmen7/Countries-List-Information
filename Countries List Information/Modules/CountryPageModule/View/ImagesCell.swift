import UIKit

final class ImagesCell: UICollectionViewCell {

    static let identifier = "ImagesCell"

    let imageView = UIImageView()
    let fetchImage = FetchImage.shared

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imageURL: String) {
        imageView.image = UIImage(named: "noimage")
        fetchImage.downloadImage(with: imageURL) { imageData, error in
            if let error = error {
                print("Failed to download image: \(error)")
            } else if let imageData, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
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
        imageView.image = UIImage(named: "noimage")
    }
}
