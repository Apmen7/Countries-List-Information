import UIKit

final class CountryInformationCell: UITableViewCell {

    // MARK: Properties
    private let countryFlag = UIImageView()
    private let countryName = UILabel()
    private let countryCapital = UILabel()
    private let countryDescription = UILabel()
    private let fetchImage = FetchImage.shared

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure Cell
    func configure(with country: Country) {
        downloadFlagImage(with: country.countryInfo.flag)
        countryName.text = country.name
        countryCapital.text = country.capital
        countryDescription.text = country.descriptionSmall
    }
}

// MARK: - SetupUI
private extension CountryInformationCell {

    func setupCell() {
        setupCountryFlag()
        setupCountryName()
        setupCountryCapital()
        setupDescription()
    }

    func downloadFlagImage(with string: String) {
        fetchImage.downloadImage(with: string) { imageData, error in
            if let error = error {
                print("No flag image", error)
                DispatchQueue.main.async {
                    self.countryFlag.image = UIImage(systemName: "flag.slash.fill")
                }
            }
            if let imageData {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.countryFlag.image = image
                    }
                }
            }
        }
    }

    func setupCountryFlag() {
        addSubview(countryFlag)
        countryFlag.contentMode = .scaleAspectFit
        countryFlag.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            countryFlag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countryFlag.topAnchor.constraint(equalTo: topAnchor),
            countryFlag.widthAnchor.constraint(equalToConstant: 60),
            countryFlag.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    func setupCountryName() {
        addSubview(countryName)
        countryName.font = .systemFont(ofSize: 19)
        countryName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            countryName.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 16),
            countryName.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
    }

    func setupCountryCapital() {
        addSubview(countryCapital)
        countryCapital.textColor = .gray
        countryCapital.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryCapital.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 16),
            countryCapital.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 4)
        ])
    }

    func setupDescription() {
        addSubview(countryDescription)
        countryDescription.numberOfLines = 0
        countryDescription.font = .systemFont(ofSize: 19)
        countryDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            countryDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countryDescription.topAnchor.constraint(equalTo: countryCapital.bottomAnchor, constant: 8),
            countryDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            countryDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
