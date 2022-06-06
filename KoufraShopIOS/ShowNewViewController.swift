//
//  ShowNewViewController.swift
//  ShopKoufra
//
//  Created by Paola Garcia on 02/06/22.
//

import UIKit
import WebKit

class ShowNewViewController: UIViewController {
    
    var recibirUrl:String?
    @IBOutlet weak var webPage: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: recibirUrl!)else{return}
        webPage.load(URLRequest(url: url))
    }
    

  

}
