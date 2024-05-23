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
