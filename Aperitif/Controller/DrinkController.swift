//
//  AlcoholicDrinkController.swift
//  Aperitif
//
//  Created by Saurav Sharma on 26/07/21.
//

import Foundation
import UIKit

class DrinkController: UIViewController {

    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkTextView: UITextView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var ingredientstextView: UITextView!
    @IBOutlet weak var glassLabel: UILabel!
    
    var drinkName: String?
    var drinkImgURL: String?
    var drinkID: String = ""
    var alcoDrinkObj = CocktailDrinkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alcoDrinkObj.delegate = self
        drinkImageView.layer.masksToBounds = true
        drinkImageView.layer.cornerRadius = 20
        
        drinkNameLabel.text = drinkName
        
        let dq = DispatchQueue(label: "BGQueue", qos: .background)
        dq.async {
            if let drinkURL = self.drinkImgURL {
                if let url = URL(string: drinkURL){
                    DispatchQueue.main.async {
                        self.drinkImageView.image = self.getImage(url: url)
                       
                    }
                }
            }else {
                print("Thumbnail URL not found")
            }
        }
        alcoDrinkObj.getCocktailDrink(drinkID: drinkID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        drinkNameLabel.text = ""
    }
    
    func getImage(url:URL)->UIImage{
        let data = try? Data(contentsOf: url)
        let loadedimage = UIImage(data: data!)
        return loadedimage!
    }
   
}

extension DrinkController: CocktailDrinkDelegate {
    func getcocktailDrinkInfo(_ drink: CocktailDrinkInfo) {
        let ingredients = drink.Ingredients
        let instructions = drink.howToMake
        let glass = drink.glass
        DispatchQueue.main.async {
            self.drinkTextView.text = instructions
            self.ingredientstextView.text = ingredients
            self.glassLabel.text = "Glass preferred : "+glass
        }
    }
}
