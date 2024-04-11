//
//  CountriesListPresenter.swift
//  Countries List Information
//
//  Created by Armen on 06.03.2024.
//

import Foundation

protocol CountriesListPresenterProtocol: AnyObject {
    func createData()
}

final class CountriesListPresenter: CountriesListPresenterProtocol {

    // MARK: Properties
    private weak var view: CountriesListViewProtocol?
    private let apiManager: DataManagerProtocol
    private var countries: [Country] = []

    init(view: CountriesListViewProtocol, apiManager: DataManagerProtocol) {
        self.view = view
        self.apiManager = apiManager
        createData()
    }

    // MARK: Getting countries from API
    func createData() {
        apiManager.getCountries { [weak self] countries in
            guard let self else {
                return
            }
            self.countries = countries
            self.view?.setCountries(countries: countries)
        }
    }
}
