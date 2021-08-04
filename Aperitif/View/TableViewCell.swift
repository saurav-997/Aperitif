//
//  TableViewCell.swift
//  Aperitif
//
//  Created by Saurav Sharma on 19/07/21.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableviewImageView: UIImageView!
    @IBOutlet weak var tableViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
