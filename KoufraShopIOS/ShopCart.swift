//
//  ShopCart.swift
//  KoufraShopIOS
//
//  Created by Paola Garcia on 05/06/22.
//

import Foundation

//para los datos del child iphone
class ShopCart {
    let cantidad:String?
    let capacidad:String?
    let imagen:String?
    let name:String?
    let precio:String?
    
    init(cant:String,cap:String,img:String,n:String,p:String){
        cantidad=cant
        capacidad=cap
        imagen=img
        name=n
        precio=p
    }
}//de la class iphone
