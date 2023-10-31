//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Hoang Linh Nguyen on 6/11/2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var balance: Int64
    @NSManaged public var name: String?
    @NSManaged public var id: String?

}
