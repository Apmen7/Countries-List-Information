//
//  FetchImagesOfCountries.swift
//  Countries List Information
//
//  Created by Armen on 29.03.2024.
//

import UIKit

final class FetchImagesOfCountries {

    static let shared = FetchImagesOfCountries()

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, let image = UIImage(data: data) else {
                print("Failed to load image from \(url):", error?.localizedDescription ?? "Unknown error")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}

// Это функция с помощью которой я раньше загружал картинки для стран.
