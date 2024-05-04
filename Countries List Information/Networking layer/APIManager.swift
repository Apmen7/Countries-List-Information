import Foundation

protocol DataManagerProtocol {
    func getCountries(completion: @escaping ([Country], String) -> Void)
    func getMoreCountries(url: String, completion: @escaping ([Country], String) -> Void)
}

final class APIManager: DataManagerProtocol {

    let url = "https://rawgit.com/NikitaAsabin/" +
    "799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"

    let secondUrl = "https://rawgit.com/" +
    "NikitaAsabin/b37bf67c8668d54a517e02fdf0e0d435/raw/2021870812a13c6dbae1f8a0e9845661396c1e8d/page2.json"

    func getCountries(completion: @escaping ([Country], String) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                return
            }
            do {
                let countriesData = try JSONDecoder().decode(CountriesData.self, from: data)
                let countries = countriesData.countries
                let nextPage = countriesData.next
                completion(countries, nextPage)
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }

    func getMoreCountries(url: String, completion: @escaping ([Country], String) -> Void) {
        guard let url = URL(string: secondUrl) else {
            print("Invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                return
            }
            do {
                let countriesData = try JSONDecoder().decode(CountriesData.self, from: data)
                let countries = countriesData.countries
                let nextPage = countriesData.next
                completion(countries, nextPage)
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
}
