//
//  HomeViewController.swift
//  ShopKoufra
//
//  Created by Paola Garcia on 01/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase



class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableItems: UITableView!
    
    var ref: DatabaseReference!=Database.database().reference().child("stock").child("iphone")
    var listado: [Iphone] = []
    var item = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //guard let userID = Auth.auth().currentUser?.uid else { return }
        //print(userID)
        tableItems.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tableItems.delegate=self
        tableItems.dataSource=self
        getItems()
        
    }//del onviewload
    
    private func getItems(){
        //obteniendo los datos del child iphone
        ref.observeSingleEvent(of: .value, with:{snapshot in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let placeDict = snap.value as! [String: Any]
                let name = placeDict["name"] as! String
                let image = placeDict["imagen"] as! String
                let categoria = placeDict["categoria"] as! String
                let capacidad = placeDict["capacidad"] as! String
                let unidades = placeDict["unidades"] as! Int
                let truetone = placeDict["truetone"] as! String
                let price = placeDict["precio"] as! Int
                let item = Iphone(tru:truetone,uni:unidades,cap: capacidad,cat: categoria,img: image,n: name,p:price)
                self.listado.append(item)
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        self.tableItems.reloadData()
                    }//DispatchQueue.main
                }//Distpachqueue.global
            }// del children
            //print("Tamanio de array: \(self.listado.count)")
        })//del observer
    }//del getItems
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listado.count
    }//del numberOfRowsInSection
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda=tableItems.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! HomeTableViewCell
        celda.lblName.text=listado[indexPath.row].name
        celda.lblCantidad.text="Capacidad: "+listado[indexPath.row].capacidad!
        celda.lblCategoria.text="Precio: $"+String(listado[indexPath.row].price!)
        let urlimagen = listado[indexPath.row].imagen ?? ""
        celda.imgItem.cargarImg(direcciones: urlimagen)

        return celda
    }//del cellForRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        item=listado[indexPath.row].name ?? ""
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItem"{
            let ObjDest=segue.destination as! ItemViewController
            ObjDest.recibirName = item
        }//yf del segue
    }//prepare segue
}// de la clase


extension UIImageView{
    func cargarImg(direcciones: String) {
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



