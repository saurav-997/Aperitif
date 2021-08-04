//
//  AlcoholicListController.swift
//  Apéritif
//
//  Created by Saurav Sharma on 15/07/21.
//

import Foundation

struct AlcoholicListController {
    
    var delegate: AlcoholicListDelegate?
    
    func getAlcoholList(){
        let finalURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic")!
        
        let task = URLSession.shared.dataTask(with: finalURL){(data,response,error) in
            if let safeData = data{
                if let alcoholicInfo = parseJSON(data: safeData){
                    self.delegate?.getAlcholicDrink(alcoholicInfo)
                }else{
                }
                
            }
                
            else{
                print(error ?? "nil")
            }
        }
        task.resume()
    }
    
    func parseJSON(data:Data)->AlcoholicListInfo?{
        let decoder = JSONDecoder()
        do {
            let newData = try decoder.decode(AlcoholicList.self, from: data)
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
            
            let AlcoholInfo = AlcoholicListInfo(drinkName: drinkName, drinkThumbURL: drinkThumbURL, drinkID: drinkID)
            return AlcoholInfo
        } catch  {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
}

protocol AlcoholicListDelegate {
    func getAlcholicDrink(_ drink: AlcoholicListInfo)
}
