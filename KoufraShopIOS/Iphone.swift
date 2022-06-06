//
//  Iphone.swift
//  ShopKoufra
//
//  Created by Paola Garcia on 04/06/22.
//

import Foundation

//para los datos del child iphone
class Iphone {
    let trueTone: String?
    let unidades: Int?
    let capacidad: String?
    let categoria:String?
    let imagen:String?
    let name:String?
    let price:Int?
    
    init(tru:String,uni:Int, cap:String, cat:String, img:String, n:String, p:Int){
        trueTone=tru
        unidades=uni
        capacidad=cap
        categoria=cat
        imagen=img
        name=n
        price=p
    }
}//de la class iphone
