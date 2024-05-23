import UIKit

protocol FetchImageProtocol {
    func downloadImage(with string: String, completion: @escaping (Data?, Error?) -> Void )
}

final class FetchImage: FetchImageProtocol {

    static let shared = FetchImage()

    func downloadImage(with string: String, completion: @escaping (Data?, Error?) -> Void ) {
        guard let url = URL(string: string) else {
            print("Invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("No data \(error)")
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
}
