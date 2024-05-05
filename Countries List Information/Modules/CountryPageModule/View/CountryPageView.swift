import UIKit

protocol CountryPageViewProtocol: AnyObject {
    func loadImages()
}

final class CountryPageView: UIViewController {

// MARK: Properties
    private let countryName = UILabel()
    private let countryDescription = UILabel()
    private let tableView = UITableView()
    private var images: [UIImage?] = []
    private let country: Country
    private let aboutLabel = UILabel()
    private let pageControl = UIPageControl()
    private let fetchImage = FetchImage.shared

    var presenter: CountryPagePresenterProtocol!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize.width = 400
        layout.itemSize.height = 400
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        loadImages()
        setupUI()
    }
}

private extension CountryPageView {
    func loadImages() {
        let stringURLs: [String] = country.countryInfo.images

        for string in stringURLs {
            fetchImage.downloadImage(with: string) { imageData, error in
                if let error {
                    print("Broken link")
                    return
                }
                if let imageData {
                    if let image = UIImage(data: imageData) {
                        self.images.append(image)
                        if self.images.count == stringURLs.count {
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                                self.pageControl.numberOfPages = self.images.count
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Configure func and cell model creating
private extension CountryPageView {
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
extension CountryPageView {

    func setupUI() {
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupCountryName()
        setupTableView()
        configure(with: country)
        setupAboutLabel()
        setupPageControl()
    }

    func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        pageControl.currentPage = 0

        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -40),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .red
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
        collectionView.dataSource = self
        collectionView.delegate = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])

        collectionView.register(ImagesCell.self, forCellWithReuseIdentifier: "\(ImagesCell.self)")
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

extension CountryPageView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}

extension CountryPageView: UITableViewDataSource, UITableViewDelegate {
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

extension CountryPageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.identifier, for: indexPath) as?
                ImagesCell else {
            return UICollectionViewCell()
        }
        cell.configure()
        cell.imageView.image = images[indexPath.row]

        return cell
    }
}
