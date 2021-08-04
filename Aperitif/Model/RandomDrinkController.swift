//
//  RandomDrink.swift
//  Aperitif
//
//  Created by Saurav Sharma on 17/07/21.
//

import Foundation

protocol RandomDrinkDelegate {
    
    func getRandomDrink(_ drink: RandomDrinkInfo)
}

struct RandomDrinkController {
    var delegate: RandomDrinkDelegate?
    func getrandomDrink(){
        let url = URL(string:  "https://www.thecocktaildb.com/api/json/v1/1/random.php")!
        let task = URLSession.shared.dataTask(with: url){(data,response,error) in
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let newData = try decoder.decode(RandomDrinkModel.self,from: safeData)
                    let name = newData.drinks[0].strDrink
                    let url = newData.drinks[0].strDrinkThumb
                    let category = newData.drinks[0].strAlcoholic
                    let instructions = newData.drinks[0].strInstructions
                    let glass = newData.drinks[0].strGlass
                    var ingredient = "\n1. \(newData.drinks[0].strIngredient1)\n"
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
                    
                    
                    let randomDrink = RandomDrinkInfo(imageURL: url, name: name,category: category,howToMake: instructions, glass: glass,Ingredients: ingredient)
               //     print(randomDrink)
                    delegate?.getRandomDrink(randomDrink)
                    
                } catch {
                    print(error)
                }
            }else{
                print(error ?? "nil")
            }
        }
        task.resume()
    }
    
}
