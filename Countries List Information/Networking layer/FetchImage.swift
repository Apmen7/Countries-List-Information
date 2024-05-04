import UIKit

protocol FetchImageProtocol {
    func downloadImage(with string: String, completion: @escaping (Data?, Error?) -> () )
}

final class FetchImage: FetchImageProtocol {

    static let shared = FetchImage()

    func downloadImage(with string: String, completion: @escaping (Data?, Error?) -> () ) {
        guard let url = URL(string: string) else {
            print("Invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("No data")
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
}
