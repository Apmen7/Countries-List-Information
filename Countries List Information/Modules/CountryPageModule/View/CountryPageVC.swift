import UIKit

final class CountryPageVC: UIViewController {

    private let countryName = UILabel()
    private let countryDescription = UILabel()
    private let tableView = UITableView()
    private var images: [UIImage] = []
    private let country: Country
    private let aboutLabel = UILabel()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    init(country: Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupUI()
    }
}

// MARK: - Configure func and cell model creating
private extension CountryPageVC {
    func configure(with country: Country) {
        countryName.text = country.name
    }

    func getCellModel(_ country: Country) -> [CountryDetailModel] {
        var countryInformation: [CountryDetailModel] = []
        countryInformation.append(
            CountryDetailModel(
                icon: "star", title: "Capital", value: country.capital
            )
        )
        countryInformation.append(
            CountryDetailModel(
                icon: "face.smiling", title: "Population", value: String(country.population)
            )
        )
        countryInformation.append(
            CountryDetailModel(
                icon: "globe.desk.fill", title: "Continent", value: country.continent
            )
        )
        return countryInformation
    }
}

// MARK: - SetupUI
extension CountryPageVC: UITableViewDelegate {

    func setupUI() {
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupCountryName()
        setupTableView()
        configure(with: country)
        setupAboutLabel()
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(DetailInformationCells.self, forCellReuseIdentifier: "DetailInformationCells")
        tableView.register(FooterOfDetailTableView.self, forHeaderFooterViewReuseIdentifier: "footer")

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupCountryName() {
        view.addSubview(countryName)
        countryName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryName.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            countryName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            countryName.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        countryName.font = .systemFont(ofSize: 25, weight: .light)
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])
    }

    func setupAboutLabel() {
        view.addSubview(aboutLabel)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.text = "About"
        aboutLabel.backgroundColor = .red

        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

// MARK: - Extension UITableViewDataSource
extension CountryPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellInformation = getCellModel(country)
        return cellInformation.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "DetailInformationCells", for: indexPath
        ) as? DetailInformationCells else {
            return UITableViewCell()
        }

        let cellInformation = getCellModel(country)
        let cellModel = cellInformation[indexPath.row]
        cell.configure(model: cellModel)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = FooterOfDetailTableView(reuseIdentifier: "footer", country: country)
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection: Int) -> CGFloat {
        return 250
    }
}
