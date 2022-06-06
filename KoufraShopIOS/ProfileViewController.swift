//
//  ProfileViewController.swift
//  ShopKoufra
//
//  Created by Paola Garcia on 05/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase

class ProfileViewController: UIViewController{

    
    //var ref: DatabaseReference!=Database.database().reference()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblApellidos: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var lblCorreo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        
        
    }
    
    func getUser(){
        let ref: DatabaseReference!=Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
        
        ref.observe(.value, with: { snapshot in
            if let u=snapshot.value as? [String:Any]{
                self.lblName.text = "Nombre: "+(u["names"] as! String)
                self.lblApellidos.text = "Apellidos :"+(u["surnames"] as! String)
                self.lblCorreo.text = "Correo: "+(u["email"] as! String)
            }//del iflet
        })// del observe
    }//del getUser
    

    @IBAction func btnGenerarPedido(_ sender: UIButton) {
    }
    
 
    @IBAction func btnCerrarSesion(_ sender: UIButton) {
        
        func logoutUser() {
            // call from any screen
            do { try Auth.auth().signOut()
                
            }
            catch { print("already logged out") }
            
            navigationController?.popToRootViewController(animated: true)
        }
    }// btnCerrar sesion
    

    
}//De la clase

extension UIImageView{
    func Img(direcciones: String) {
        guard let url = URL(string: direcciones) else {return}
        
        DispatchQueue.main.async {
            if let imagenData = try? Data(contentsOf: url){
                if let imagenCargada = UIImage(data: imagenData){
                    self.image = imagenCargada
                }
            }
        }
    }
}


