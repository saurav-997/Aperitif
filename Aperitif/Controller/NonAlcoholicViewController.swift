//
//  NonAlcoholicViewController.swift
//  Aperitif
//
//  Created by Saurav Sharma on 30/07/21.
//

import Foundation
import UIKit

class NonAlcoholicViewController: UIViewController {
    
    @IBOutlet weak var UItableView: UITableView!
    
    var nonalcoholDrink = NonAlcoholicListController()
    var numOfMocktails = 0
    var nonAlcDrinkName: [String] = []
    var nonAlcdrinkThumbURl: [String] = []
    var nonAlcdrinkID: [String] = []

    var drinkNameOnClick : String = ""
    var drinkImgURLOnClick: String = ""
    var drinkIDonClick: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nonalcoholDrink.delegate = self
        nonalcoholDrink.getNonAlcoholicList()
        self.UItableView.dataSource = self
        self.UItableView.delegate = self
        self.UItableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier")
    }
}

extension NonAlcoholicViewController: NonAlcoholicDrinkDelegate {
    func getNonAlocholicDrink(_ drink: NonAlcoholicListInfo) {
        numOfMocktails = drink.drinkName.count
        nonAlcDrinkName = drink.drinkName
        nonAlcdrinkThumbURl = drink.drinkThumbURL
        nonAlcdrinkID = drink.drinkID
        DispatchQueue.main.async {
            self.UItableView.reloadData()
        }
    }
    
}

extension NonAlcoholicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfMocktails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath) as! TableViewCell
        cell.tableViewLabel.text = nonAlcDrinkName[indexPath.row]
        
        DispatchQueue.main.async {
            let url = URL(string: self.nonAlcdrinkThumbURl[indexPath.row])
            if let imgUrl = url {
                cell.tableviewImageView.kf.setImage(with: imgUrl)
            }
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        drinkNameOnClick = nonAlcDrinkName[indexPath.row]
        drinkImgURLOnClick = nonAlcdrinkThumbURl[indexPath.row]
        drinkIDonClick = nonAlcdrinkID[indexPath.row]
       
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showMocktail", sender: self)
        }
    }
    
    func getImage(url:URL)->UIImage{
        let data = try? Data(contentsOf: url)
        let loadedimage = UIImage(data: data!)
        return loadedimage!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newVC = segue.destination as? DrinkController else {
            return
        }
        newVC.drinkID = drinkIDonClick
        newVC.drinkName = drinkNameOnClick
        newVC.drinkImgURL = drinkImgURLOnClick
    }
}
