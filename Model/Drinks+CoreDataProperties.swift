//
//  Drinks+CoreDataClass.swift
//  Barman
//
//  Created by Israel Aguilar on 10/23/24.
//
//

import Foundation
import CoreData


extension Drinks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drinks> {
        return NSFetchRequest<Drinks>(entityName: "Drinks")
    }

    @NSManaged public var directions: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?
    @NSManaged public var img: String?

}

extension Drinks : Identifiable {

}
