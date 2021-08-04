//
//  CocktailDrinkModel.swift
//  Aperitif
//
//  Created by Saurav Sharma on 29/07/21.
//

import Foundation

struct CocktailDrinkModel: Decodable {
    let drinks: [cocktailDrink]
}

struct cocktailDrink: Decodable {
    let strGlass: String
    let strInstructions: String
    let strIngredient1: String
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
}
