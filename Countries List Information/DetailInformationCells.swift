import UIKit

final class DetailInformationCells: UITableViewCell {

    private let valueLabel = UILabel()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        setupValueLabel()
        setupTitleLabel()
    }

    func configure(model: CountryDetailModel) {
        valueLabel.text = model.value
        titleLabel.text = model.title
        setupIconImageView(icon: model.icon)
    }

    func setupValueLabel() {
        addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textColor = .systemGray
        valueLabel.font = .systemFont(ofSize: 20)

        NSLayoutConstraint.activate([
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }

    func setupIconImageView(icon: String) {
        addSubview(iconImageView)
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .orange
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 20)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
