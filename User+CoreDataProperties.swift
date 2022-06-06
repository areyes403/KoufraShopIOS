//
//  User+CoreDataProperties.swift
//  KoufraShopIOS
//
//  Created by Paola Garcia on 05/06/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var pass: String?

}

extension User : Identifiable {

}
