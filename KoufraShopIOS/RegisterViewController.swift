//
//  RegisterViewController.swift
//  ShopKoufra
//
//  Created by Paola Garcia on 01/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference!=Database.database().reference()

    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfNames: UITextField!
    @IBOutlet weak var tfSurnames: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register.layer.cornerRadius=10

    }
    
    @IBAction func btnRegister(_ sender: Any) {
        
        //Para agregar en firebase
        //ref.child("users").child("value").setValue("testing")
        
        
        if let email = tfEmail.text,let pass=tfPass.text, let names=tfNames.text,let surnames=tfSurnames.text{
            Auth.auth().createUser(withEmail: email, password: pass){ resultado, error in
                if let e = error{
                    print("Error a lcrear el usuario")
                }else{
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("id").setValue(Auth.auth().currentUser!.uid)
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("email").setValue(email)
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("password").setValue(pass)
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("names").setValue(names)
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("surnames").setValue(surnames)
                    self.ref.child("stock").child("iphone").setValue("test")
                    print("usuario creado")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }// del button
    
    
}// de la clase
