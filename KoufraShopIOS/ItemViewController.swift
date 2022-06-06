//
//  ItemViewController.swift
//  ShopKoufra
//
//  Created by Paola Garcia on 04/06/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class ItemViewController: UIViewController {

    var recibirName:String?
    
    @IBOutlet weak var lblCantidad: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var lbltrueTone: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    
    let alert=UIAlertController(title: "Agregado al carrito", message: "Se agrego correctamente", preferredStyle: .alert)
    
    //var ref: DatabaseReference!=Database.database().reference().child("carrito").child(Auth.auth().currentUser!.uid)
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getitem()
        lblUrl.isHidden=true
        
    }//del viewDidLoad
    
    func getitem(){
        let ref: DatabaseReference!=Database.database().reference().child("stock").child("iphone").child(recibirName!)
        ref.observe(.value, with: {snapshot in
            if let i = snapshot.value as? [String:Any] {
                let url=(i["imagen"] as! String)
                print(url)
                let n = (i["name"] as! String)
                let c = String(i["unidades"] as! Int)
                let p = String(i["precio"] as! Int)
                let cat = (i["categoria"] as! String)
                self.lblUrl.text=url
                self.imgItem.cargarImg(direcciones: url)
                self.lblName.text="\(n)"
                self.lblCantidad.text="Unidades disponibles :\(c)"
                self.lblPrecio.text = "Precio: $\(p)"
                self.lblCategoria.text = "Categoria: \(cat)"
                
            }//del snapshot
           })//del observe
    }
    
    @IBAction func btnAddCart(_ sender: Any) {
        let name = lblName.text!
        let precio = lblPrecio.text!
        let imagen = lblUrl.text!
        let capacidad = "64"
        let cantidad = "1"

        /*
        let newItem = Carrito (context: contexto)
        newItem.nombre="test"
        newItem.precio="test"
        newItem.imagen="test"
        newItem.cantidad="test"
        newItem.capacidad="test"
        self.guardar()*/
        
        //self.ref.child("stock").child("iphone").child("Iphone 11 pro").child("name").setValue("Iphone 11 pro")
        let ref: DatabaseReference!=Database.database().reference().child("carrito").child(Auth.auth().currentUser!.uid).child(name)
        ref.child("nombre").setValue(name)
        ref.child("precio").setValue(precio)
        ref.child("imagen").setValue(imagen)
        ref.child("capacidad").setValue(capacidad)
        ref.child("cantidad").setValue(cantidad)
        dismiss (animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnSalir(_ sender: UIButton) {
        dismiss (animated: true, completion: nil)
    }
    
    
}


extension UIImageView{
    func cargar(direcciones: String) {
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
