//
//  HomeTableViewCell.swift
//  ShopKoufra
//
//  Created by Paola Garcia on 04/06/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelectedItem: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnPickItem(_ sender: Any) {
    }
}
