//
//  AlcoholicList.swift
//  Apéritif
//
//  Created by Saurav Sharma on 15/07/21.
//

import Foundation


struct AlcoholicList: Decodable {
    let drinks: [alcoList]
}

struct alcoList: Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
}
