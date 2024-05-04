//
//  CountryPagePresenter.swift
//  Countries List Information
//
//  Created by Armen on 10.04.2024.
//

import Foundation

protocol CountryPagePresenterProtocol: AnyObject {
}

final class CountryPagePresenter: CountryPagePresenterProtocol {

    // MARK: Properties
    private weak var view: CountryPageViewProtocol?

    init(view: CountryPageViewProtocol) {
        self.view = view
    }
}
