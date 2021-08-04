//
//  Non-Alcoholic.swift
//  Apéritif
//
//  Created by Saurav Sharma on 15/07/21.
//

import Foundation


struct NonAlcoholicList: Decodable {
    let drinks: [nonAlcoList]
}

struct nonAlcoList: Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
}
