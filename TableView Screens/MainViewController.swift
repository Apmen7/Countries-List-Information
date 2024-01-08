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

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

final class CustomCell: UITableViewCell {
    let countryFlag = UIImageView()
    var countryName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    private func setupCell() {
        addSubview(countryFlag)
        addSubview(countryName)

        countryFlag.contentMode = .scaleAspectFit

        countryFlag.translatesAutoresizingMaskIntoConstraints = false
        countryName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            countryFlag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countryFlag.widthAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            countryName.topAnchor.constraint(equalTo: topAnchor),
            countryName.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor)
        ])

    }

    required init? (coder: NSCoder) {
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
        cell?.countryName.text = country.description

        return cell!
    }

}

// MARK: - Extension UITableViewDelegate
extension MainViewController: UITableViewDelegate {

}
