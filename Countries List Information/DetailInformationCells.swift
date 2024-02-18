import UIKit

final class DetailInformationCells: UITableViewCell {

    private let capitalName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with country: Country) {
        capitalName.text = country.capital
    }

    func setupCell() {
        setupCapitalName()
    }

    func setupCapitalName() {
        addSubview(capitalName)
        capitalName.translatesAutoresizingMaskIntoConstraints = false
        capitalName.textColor = .systemGray

        NSLayoutConstraint.activate([
            capitalName.trailingAnchor.constraint(equalTo: trailingAnchor),
            capitalName.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
