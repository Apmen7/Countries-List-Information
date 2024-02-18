import Foundation

final class APIManager {

    func getCountries(completion: @escaping ([Country]) -> Void) {
        guard let url = URL(string: "https://rawgit.com/NikitaAsabin/" +
"799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json") else {
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
                completion(countries)
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
}
