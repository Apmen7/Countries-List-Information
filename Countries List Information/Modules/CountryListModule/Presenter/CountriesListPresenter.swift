import Foundation

protocol CountriesListPresenterProtocol: AnyObject {
    func createData()
    func loadMoreData()
    var isPaginationAvailable: Bool { get }
}

final class CountriesListPresenter: CountriesListPresenterProtocol {

    // MARK: Properties
    private weak var view: CountriesListViewProtocol?
    private let apiManager: DataManagerProtocol
    private var countries: [Country] = []
    private var nextPage = ""
    private(set) var isPaginationAvailable = true

    init(view: CountriesListViewProtocol, apiManager: DataManagerProtocol) {
        self.view = view
        self.apiManager = apiManager
        createData()
    }

    func createData() {
        apiManager.getCountries { [weak self] countries, nextPage in
            guard let self else {
                return
            }
            self.nextPage = nextPage
            self.countries = countries
            self.view?.setCountries(countries: countries)
            isPaginationAvailable = true
        }
    }

    func loadMoreData() {
        apiManager.getMoreCountries(url: nextPage) { [weak self] countries, _ in
            guard let self else {
                return
            }
            self.countries.append(contentsOf: countries)
            self.view?.setCountries(countries: self.countries)
            self.nextPage = nextPage
            self.isPaginationAvailable = false
        }
    }
}
