//
//  TablaCarritoViewController.swift
//  KoufraShopIOS
//
//  Created by Paola Garcia on 05/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase

class TablaCarritoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var carrito:[ShopCart] = []

    @IBOutlet weak var tableCarrito: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCarrito.delegate=self
        tableCarrito.dataSource=self
        tableCarrito.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaCarrito")
        // Do any additional setup after loading the view.
        getCart()
    }
    
    func getCart(){
        print("Entre a getCart")
        let ref: DatabaseReference!=Database.database().reference().child("carrito").child(Auth.auth().currentUser!.uid)
        
        ref.observeSingleEvent(of: .value, with: {
            snapshot in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let obj = snap.value as! [String: Any]
                //print(obj)
                let cantidad = obj["cantidad"] as! String
                let precio = obj["precio"] as! String
                let image = obj["imagen"] as! String
                let capacidad = obj["capacidad"] as! String
                let name = obj["nombre"] as! String
                let articulo=ShopCart(cant:String(cantidad), cap:String(capacidad), img: image, n: name, p: String(precio))
                self.carrito.append(articulo)
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        self.tableCarrito.reloadData()
                    }//DispatchQueue.main
                }//Distpachqueue.global
                
            }//del for
            print("Tamanio>\(self.carrito.count)")
        })//del observer
        
    }//del getcart
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrito.count
    }//numberOfRows
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableCarrito.dequeueReusableCell(withIdentifier: "celdaCarrito", for: indexPath) as! CartTableViewCell
        celda.lblName.text=carrito[indexPath.row].name
        celda.lblPrecio.text="Precio: $"+carrito[indexPath.row].precio!
        celda.lblCantidad.text="Cantidad: "+carrito[indexPath.row].cantidad!
        celda.lblCapacidad.text="Almacenamiento: "+carrito[indexPath.row].capacidad!
        let urlimagen = carrito[indexPath.row].imagen ?? ""
        celda.imageCart.Img(direcciones: urlimagen)
        print("Desde el table view: "+carrito[indexPath.row].name!)
        return celda
    }//cellForRowAt

}
