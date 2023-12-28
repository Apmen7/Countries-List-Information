//
//  model.swift
//  iOS Test Task
//
//  Created by Armen on 08.01.2024.
//

import UIKit

final class Country {
    
    static var countries = [Country]()
    
    let name: String
    let capital: String
    let description: String
    let image: String
    
    init(name: String, capital: String, description: String, image: String) {
        self.name = name
        self.capital = capital
        self.description = description
        self.image = image
        Country.countries.append(self)
    }
}

private let argentina = Country(
    name: "Argentina",
    capital: "Buenos Aires",
    description: "In 2004, I completed two Inuit art buying trips to Iqaluit, the capital of Nunavut, Canada’s newest territory. For both trips, I flew out of Ottawa on Canadian airlines.",
    image: "arg"
)

private let brazil = Country(
    name: "Brazil",
    capital: "Brasilia",
    description: "You might remember the Dell computer commercials in which a youth reports this exciting news to his friends.",
    image: "bra"
)

private let domonicanRepublic = Country(
    name: "Dominican Republic",
    capital: "Santo Domingo",
    description: "",
    image: "dom"
)

private let elSalvador = Country(
    name: "El Salvador",
    capital: "San Salvador",
    description: "A lot about how you go about getting this first telescope will depend on your own expertise in astronomy.",
    image: "sal"
)






