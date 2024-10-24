//
//  Drinks+CoreDataClass.swift
//  Barman
//
//  Created by Israel Aguilar on 10/23/24.
//
//

import Foundation
import CoreData

@objc(Drinks)
public class Drinks: NSManagedObject {
    func inicializaCon(_ dict: Dictionary<String, Any>) {
        let name = (dict["name"] as? String) ?? ""
        let img = (dict["img"] as? String) ?? ""
        let ingredients = (dict["ingredients"] as? String) ?? ""
        let directions = (dict["directions"] as? String) ?? ""
        
        self.name = name
        self.img = img
        self.ingredients = ingredients
        self.directions = directions
    }
}
