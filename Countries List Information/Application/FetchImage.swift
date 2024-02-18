import UIKit

final class FetchImage {

    static let shared = FetchImage()

    private init() {

    }

    func downloadFlags(with country: Country, imageView: UIImageView) {
        guard let url = URL(string: country.countryInfo.flag) else {
            print("Invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error loading image: \(error)")
                return
            }

            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        task.resume()
    }

}
