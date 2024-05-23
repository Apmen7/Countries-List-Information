import Foundation

struct Country: Decodable {
    let name: String
    let continent: String
    let capital: String
    let population: Int
    let descriptionSmall: String
    let description: String
    let image: String
    let countryInfo: CountryInfo

    enum CodingKeys: String, CodingKey {
        case name, continent, capital, population
        case descriptionSmall = "description_small"
        case description, image
        case countryInfo = "country_info"
    }
}

struct CountryInfo: Codable {
    let images: [String]
    let flag: String
}

struct CountriesData: Decodable {
    let next: String
    let countries: [Country]
}
