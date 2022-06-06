//
//  Carrito+CoreDataProperties.swift
//  KoufraShopIOS
//
//  Created by Paola Garcia on 05/06/22.
//
//

import Foundation
import CoreData


extension Carrito {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Carrito> {
        return NSFetchRequest<Carrito>(entityName: "Carrito")
    }

    @NSManaged public var imagen: String?
    @NSManaged public var cantidad: String?
    @NSManaged public var precio: String?
    @NSManaged public var nombre: String?
    @NSManaged public var capacidad: String?

}

extension Carrito : Identifiable {

}
