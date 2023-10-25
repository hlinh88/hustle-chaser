//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var totalBalance: Int64
    @NSManaged public var income: Int64
    @NSManaged public var outcome: Int64

}
