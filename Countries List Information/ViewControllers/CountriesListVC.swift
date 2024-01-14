//
//  ViewController.swift
//  iOS Test Task
//
//  Created by Armen on 28.12.2023.
//

import UIKit

final class CountriesListVC: UIViewController {

private var countries = [Country]()
private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        setupUI()
    }
}

// MARK: - Extension UITableViewDataSource
extension CountriesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryInformationCell else { fatalError("The tableView could not dequeue a CustomCell in ViewController") }
        let country = countries[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: country)
        return cell
    }
}

// MARK: - Extension UITableViewDelegate
extension CountriesListVC: UITableViewDelegate {

}

// MARK: - Private functions
private extension CountriesListVC {

    func setupUI() {
        title = "Countries"
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CountryInformationCell.self, forCellReuseIdentifier: "cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func fillData() {

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
}
