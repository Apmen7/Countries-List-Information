import UIKit

protocol CountriesListViewProtocol: AnyObject {
    func setCountries(countries: [Country])
    func setupUI()
}

final class CountriesListView: UIViewController {

// MARK: Properties
    private let apiManager = APIManager()
    private let tableView = UITableView()
    private var countries: [Country] = []
    
    var presenter: CountriesListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

// MARK: - Extension UITableViewDelegate
extension CountriesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        let countryPageVC = CountryPageVC(country: country)

        navigationController?.pushViewController(countryPageVC, animated: true)
    }
}


extension CountriesListView: CountriesListViewProtocol {
// MARK: - Set countries func
    func setCountries(countries: [Country]) {
        self.countries = countries
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
// MARK: - SetupUI
    func setupUI() {
        title = "Countries"
        setupTableView()
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
}
