import UIKit

final class CountryPageVC: UIViewController {

    private let countryName = UILabel()
    private let countryCapital = UILabel()
    private let countryDescription = UILabel()
    private let tableView = UITableView()
    private let cellsName = ["Capital", "Population", "Continent"]
    private let cellsIcons = ["star", "face.smilling", "earth", "globe.desk.fill"]

    private let symbol = UIImage(systemName: "globe.desk.fill")

    private var images: [UIImage] = []

    private let country: Country

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)

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

        self.collectionView.dataSource = self
    }

    func configure(with country: Country) {
        countryName.text = country.name
        countryCapital.text = country.capital
        countryDescription.text = country.description
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.dataSource = self

        tableView.register(DetailInformationCells.self, forCellReuseIdentifier: "DetailInformationCells")

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: countryName.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupUI() {
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupCountryName()
        setupTableView()
        configure(with: country)
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
}

// MARK: - SetupUI
private extension CountryPageVC {

}

// MARK: -ImagesCollectionViewSetup
extension CountryPageVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier, for: indexPath) as? ImagesCollectionViewCell else {
            return UICollectionViewCell()
        }

        let image = self.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
}

// MARK: - Extension UITableViewDataSource
extension CountryPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellsName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "DetailInformationCells", for: indexPath
        ) as? DetailInformationCells else {
            return UITableViewCell()
        }

        let country = country
        cell.configure(with: country)
        return cell
    }
}
