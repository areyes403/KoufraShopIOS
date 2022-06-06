//
//  CartTableViewCell.swift
//  KoufraShopIOS
//
//  Created by Paola Garcia on 05/06/22.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCapacidad: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageCart: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
