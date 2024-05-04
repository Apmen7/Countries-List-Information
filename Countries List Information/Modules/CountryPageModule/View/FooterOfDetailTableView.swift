import UIKit

final class FooterOfDetailTableView: UITableViewHeaderFooterView {
    
    static let identifier = "TableFooter"

    private let aboutLabel = UILabel()
    private let textView = UITextView()
    private var country: Country

    init(reuseIdentifier: String?, country: Country) {
        self.country = country
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        setupAboutLabel()
        setupDescriptionTextView()
    }

    func setupAboutLabel() {
        contentView.addSubview(aboutLabel)

        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.text = "About"
        aboutLabel.font = .systemFont(ofSize: 20)

        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            aboutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            aboutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
        ])
    }

    func setupDescriptionTextView() {
        contentView.addSubview(textView)
        textView.text = country.description
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
    }
}
