import UIKit

final class CountriesListVC: UIViewController {

    private let apiManager = APIManager()
    private let tableView = UITableView()
    private var countries: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createData()
    }
}

// MARK: - Extension UITableViewDataSource
extension CountriesListVC: UITableViewDataSource {
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
extension CountriesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        let countryPageVC = CountryPageVC(country: country)

        navigationController?.pushViewController(countryPageVC, animated: true)
    }
}

// MARK: - SetupUI
private extension CountriesListVC {

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

// MARK: - Creating Data
private extension CountriesListVC {

    func createData() {

        apiManager.getCountries { [weak self] countries in
            guard let self = self else {
                return
            }
            self.countries = countries

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
