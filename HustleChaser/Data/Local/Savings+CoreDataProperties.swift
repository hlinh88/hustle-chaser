//
//  Savings+CoreDataProperties.swift
//  
//
//  Created by Hoang Linh Nguyen on 18/11/2023.
//
//

import Foundation
import CoreData


extension Savings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Savings> {
        return NSFetchRequest<Savings>(entityName: "Savings")
    }

    @NSManaged public var color: Int64
    @NSManaged public var current: Int64
    @NSManaged public var days: Int64
    @NSManaged public var name: String?
    @NSManaged public var target: Int64

}
