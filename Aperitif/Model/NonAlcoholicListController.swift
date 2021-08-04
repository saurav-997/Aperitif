//
//  Non-AlcoholicListController.swift
//  Apéritif
//
//  Created by Saurav Sharma on 15/07/21.
//

import Foundation

struct NonAlcoholicListController {
    
    var delegate: NonAlcoholicDrinkDelegate?
    
    func getNonAlcoholicList(){
        let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
        if let finalURL = URL(string: url)
        {
            let task = URLSession.shared.dataTask(with: finalURL){(data,response,error) in
                if let safeData = data{
                    print(safeData)
                    if let nonAlcoDrinkList = parseJSON(data: safeData){
                        self.delegate?.getNonAlocholicDrink(nonAlcoDrinkList)
                    }else{
                        
                    }
                }
                else{
                    print(error ?? "No data found")
                }
            }
            
            task.resume()
        }else{
            print("drink URL/Name not found")
        }
    }
    func parseJSON(data:Data)->NonAlcoholicListInfo?{
        let decoder = JSONDecoder()
        do {
            let newData = try decoder.decode(NonAlcoholicList.self, from: data)
            let count = newData.drinks.count
            var drinkName: [String] = []
            var drinkThumbURL: [String] = []
            var drinkID: [String] = []
            var i = 0
            while i<count {
                drinkName.insert("\(newData.drinks[i].strDrink)",at: i)
                i = i+1
            }
            i = 0
            while i<count {
                drinkThumbURL.insert("\(newData.drinks[i].strDrinkThumb)",at: i)
                i = i+1
            }
            i = 0
            while i<count {
                drinkID.insert("\(newData.drinks[i].idDrink)",at: i)
                i = i+1
            }
            
            
            let nonAlcoholInfo = NonAlcoholicListInfo(drinkName: drinkName, drinkThumbURL: drinkThumbURL, drinkID: drinkID)
            return nonAlcoholInfo
        } catch  {
            print(error.localizedDescription)
            return nil
        }
        
    }
}
protocol NonAlcoholicDrinkDelegate {
    func getNonAlocholicDrink(_ drink: NonAlcoholicListInfo)
}
