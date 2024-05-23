import UIKit

protocol CountriesListViewProtocol: AnyObject {
    func setCountries(countries: [Country])
}

final class CountriesListView: UIViewController {

    // MARK: Properties
    private let apiManager = APIManager()
    private let tableView = UITableView()
    private let indicator = UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    private var countries: [Country] = []
    private var nextPage: String = ""

// swiftlint:disable:next implicitly_unwrapped_optional
    var presenter: CountriesListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshControl()
    }
}

extension CountriesListView {

    @objc
    func refreshData() {
        presenter.createData()
        self.tableView.refreshControl?.endRefreshing()
    }

    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

// MARK: - Extension UITableViewDataSource
extension CountriesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CountryInformationCell", for: indexPath
        ) as? CountryInformationCell else {
            return UITableViewCell()
        }
        let country = countries[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: country)
        return cell
    }
}

extension CountriesListView {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == countries.count - 1, presenter.isPaginationAvailable {
            indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.presenter.loadMoreData()
                self.indicator.stopAnimating()
            }
        }
    }
}

// MARK: - Extension UITableViewDelegate
extension CountriesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        let countryPageVC = CountryPageView(country: country)

        navigationController?.pushViewController(countryPageVC, animated: true)
    }
}

extension CountriesListView: CountriesListViewProtocol {

    func setCountries(countries: [Country]) {
        self.countries = countries
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func setupUI() {
        title = "Countries"
        setupTableView()
        setupActivityIndicator()
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CountryInformationCell.self, forCellReuseIdentifier: "CountryInformationCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupActivityIndicator() {
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true

        NSLayoutConstraint.activate([
            indicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
