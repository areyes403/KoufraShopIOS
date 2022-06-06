//
//  ViewController.swift
//  KoufraShopIOS
//
//  Created by Paola Garcia on 05/06/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {


    @IBOutlet weak var sigin: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var up: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    
    let alert=UIAlertController(title: "Error de autenticacion", message: "Usuario y/o contraseña incorrecta", preferredStyle: .alert)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sigin.layer.cornerRadius = 10; // this value vary as per your desire
        up.layer.cornerRadius = 10
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
    }


    @IBAction func btnSIGIN(_ sender: Any) {
        
        if let email = tfEmail.text , let pass = tfPassword.text{
            print(email+pass)
            
            Auth.auth().signIn(withEmail: email, password: pass){[weak self] authResult, error in
                if let e = error{
                    print("Error al autenticar")
                    // show the alert
                    self!.showAlert()

                }else{
                    print("correcto")
                    self!.performSegue(withIdentifier: "goToHome", sender: sender)
                }//else
            }//del Auth
        }//del if let
        
        
    }
    
    func showAlert(){
        self.present(alert, animated: true, completion: nil)
    }
    
}

