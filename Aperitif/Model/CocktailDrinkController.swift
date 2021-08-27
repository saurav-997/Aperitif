//
//  CocktailDrinkController.swift
//  Aperitif
//
//  Created by Saurav Sharma on 29/07/21.
//

import Foundation

protocol CocktailDrinkDelegate {
    
    func getcocktailDrinkInfo(_ drink: CocktailDrinkInfo)
}
struct CocktailDrinkController {
    
    var delegate: CocktailDrinkDelegate?
    
    func getCocktailDrink(drinkID: String) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(drinkID)"
     //   print(urlString)
        
        if let finalURL = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: finalURL){(data,response,error) in
                if let safeData = data{
                    if let alcoholicInfo = parseJSON(data: safeData){
                        self.delegate?.getcocktailDrinkInfo(alcoholicInfo)
                    }else{
                        
                    }
                }
                else{
                    print(error ?? "nil")
                }
            }
            task.resume()
        }else{
            print("drink URL/Name not found")
        }
    }
    
    func parseJSON(data:Data)->CocktailDrinkInfo?{
        let decoder = JSONDecoder()
        do {
            let newData = try decoder.decode(CocktailDrinkModel.self,from: data)
            let instructions = newData.drinks[0].strInstructions
            let glass = newData.drinks[0].strGlass
            var ingredient = "1. \(newData.drinks[0].strIngredient1)\n"
            if let ING2 = newData.drinks[0].strIngredient2 {
                ingredient += "2. \(ING2)\n"
            }
            if let ING3 = newData.drinks[0].strIngredient3{
                ingredient += "3. \(ING3)\n"
            }
            if let ING4 = newData.drinks[0].strIngredient4{
                ingredient += "4. \(ING4)\n"
            }
            if let ING5 = newData.drinks[0].strIngredient5{
                ingredient += "5. \(ING5)\n"
            }
            if let ING6 = newData.drinks[0].strIngredient6{
                ingredient += "6. \(ING6)\n"
            }
            if let ING7 = newData.drinks[0].strIngredient7{
                ingredient += "7. \(ING7)\n"
            }
            if let ING8 = newData.drinks[0].strIngredient8{
                ingredient += "8. \(ING8)\n"
            }
            if let ING9 = newData.drinks[0].strIngredient9{
                ingredient += "9. \(ING9)\n"
            }
            if let ING10 = newData.drinks[0].strIngredient10{
                ingredient += "10. \(ING10)\n"
            }
            if let ING11 = newData.drinks[0].strIngredient11{
                ingredient += "11. \(ING11)\n"
            }
            if let ING12 = newData.drinks[0].strIngredient12{
                ingredient += "12. \(ING12)\n"
            }
            
            let cocktailDrink = CocktailDrinkInfo(Ingredients: ingredient, howToMake: instructions, glass: glass)
            return cocktailDrink
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
