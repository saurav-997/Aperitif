//
//  AlcoholicViewController.swift
//  Aperitif
//
//  Created by Saurav Sharma on 19/07/21.
//

import Foundation
import UIKit

class AlcoholicViewController: UIViewController{
    
    @IBOutlet weak var UItableView: UITableView!
    
    var alcoholDrink = AlcoholicListController()
    var numOfCocktails = 0
    var drinkName: [String] = []
    var drinkThumbURl: [String] = []
    var drinkID: [String] = []
    var drinkGlass: [String] = []

    var drinkNameOnClick : String = ""
    var drinkImgURLOnClick: String = ""
    var drinkIDonClick: String = ""
    var drinkGlassOnClick: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alcoholDrink.delegate = self
        alcoholDrink.getAlcoholList()
        self.UItableView.dataSource = self
        self.UItableView.delegate = self
        self.UItableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier")
    }
    
}

extension AlcoholicViewController: AlcoholicListDelegate{
    func getAlcholicDrink(_ drink: AlcoholicListInfo) {
        numOfCocktails = drink.drinkName.count
        drinkName = drink.drinkName
        drinkThumbURl = drink.drinkThumbURL
        drinkID = drink.drinkID
        
        DispatchQueue.main.async {
            self.UItableView.reloadData()
        }
    }
}


extension AlcoholicViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfCocktails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath) as! TableViewCell
        cell.tableViewLabel.text = drinkName[indexPath.row]
        
        DispatchQueue.main.async {
            let url = URL(string: self.drinkThumbURl[indexPath.row])
            if let imgUrl = url {
                cell.tableviewImageView.kf.setImage(with: imgUrl)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        drinkNameOnClick = drinkName[indexPath.row]
        drinkImgURLOnClick = drinkThumbURl[indexPath.row]
        drinkIDonClick = drinkID[indexPath.row]
        drinkGlassOnClick = drinkID[indexPath.row]
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showAlcoholDrink", sender: self)
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
