//
//  ViewController.swift
//  Aperitif
//
//  Created by Saurav Sharma on 16/07/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var dayDrinkView: UIView!
    @IBOutlet weak var drinkofDayName: UILabel!
    @IBOutlet weak var drinkofDayImage: UIImageView!
    @IBOutlet weak var drinkofDayImagetrailingConstriant: NSLayoutConstraint!

    @IBOutlet weak var idealGlassLabel: UILabel!
    @IBOutlet weak var drinkofDayInfoTextView: UITextView!
    @IBOutlet weak var drinkofDaycategoryLabel: UILabel!
    @IBOutlet weak var alcoholicView: UIView!
    @IBOutlet weak var nonalcoholicView: UIView!
    
    var getDrinkofDay = RandomDrinkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkofDayImage.layer.masksToBounds = true
        drinkofDayImage.layer.cornerRadius = 20
        dayDrinkView.layer.cornerRadius = 15
        centerView.layer.cornerRadius = 2
        alcoholicView.layer.cornerRadius = 10
        nonalcoholicView.layer.cornerRadius = 10
        
        getDrinkofDay.delegate = self
        getDrinkofDay.getrandomDrink()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drinkofDayImagetrailingConstriant.constant -= self.view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.5, delay: 1.0, options: .curveEaseOut, animations: {
            self.drinkofDayImagetrailingConstriant.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func alcholocButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func soberButtonPressed(_ sender: UIButton) {
        
        
    }
    
    
}

extension ViewController: RandomDrinkDelegate{
   
    func getRandomDrink(_ drink: RandomDrinkInfo) {
        
        let imgUrl = URL(string: drink.imageURL)

        DispatchQueue.main.async {
            self.drinkofDayImage.kf.setImage(with: imgUrl)
            self.drinkofDayName.text = drink.name
            self.drinkofDaycategoryLabel.text = "Type: \(drink.category)"
            self.idealGlassLabel.text = "Glass: \(drink.glass)"
            self.drinkofDayInfoTextView.text = "Ingredients: \(drink.Ingredients)\nHow to make:\n\(drink.howToMake)"
           
        }
    }

}

