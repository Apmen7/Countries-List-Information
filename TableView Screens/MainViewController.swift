//
//  ViewController.swift
//  iOS Test Task
//
//  Created by Armen on 28.12.2023.
//

import UIKit

final class MainViewController: UIViewController {

private var countries = [Country]()
private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        setupUI()
    }

    private func fillData() {

    let argentina = Country(
    name: "Argentina",
    capital: "Buenos Aires",
    description: "In 2004, I completed two Inuit art buying trips to Iqaluit, the capital of Nunavut, Canada’s newest territory. For both trips, I flew out of Ottawa on Canadian airlines.",
    image: "arg"
    )
    countries.append(argentina)

    let brazil = Country(
        name: "Brazil",
        capital: "Brasilia",
        description: "You might remember the Dell computer commercials in which a youth reports this exciting news to his friends.",
        image: "bra"
    )
    countries.append(brazil)

        let dominicanRepublic = Country(
            name: "Dominican Republic",
            capital: "Santo Domingo",
            description: "",
            image: "dom"
        )
        countries.append(dominicanRepublic)

        let elSalvador = Country(
            name: "El Salvador",
            capital: "San Salvador",
            description: "A lot about how you go about getting this first telescope will depend on your own expertise in astronomy.",
            image: "sal"
        )
        countries.append(elSalvador)
    }

    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

final class CustomCell: UITableViewCell {
    let countryFlag = UIImageView()
    let countryName = UILabel()
    let countryCapital = UILabel()
    let countryDescription = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    private func setupCell() {
        setupCountryFlag()
        setupCountryName()
        setupCountryCapital()
        setupDescription()
    }

    private func setupCountryFlag() {
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

    private func setupCountryName() {
        addSubview(countryName)
        countryName.font = .systemFont(ofSize: 19)
        countryName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            countryName.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 16),
            countryName.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
    }

    private func setupCountryCapital() {
        addSubview(countryCapital)
        countryCapital.textColor = .gray
        countryCapital.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryCapital.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 16),
            countryCapital.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 4)
        ])
    }

    private func setupDescription() {
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell
        let country = countries[indexPath.row]
        cell?.countryFlag.image = UIImage(named: country.image)
        cell?.countryName.text = country.name
        cell?.countryCapital.text = country.capital
        cell?.countryDescription.text = country.description
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

}

// MARK: - Extension UITableViewDelegate
extension MainViewController: UITableViewDelegate {

}
