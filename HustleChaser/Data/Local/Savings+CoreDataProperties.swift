//
//  Savings+CoreDataProperties.swift
//  
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//
//

import Foundation
import CoreData


extension Savings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Savings> {
        return NSFetchRequest<Savings>(entityName: "Savings")
    }

    @NSManaged public var goal: String?
    @NSManaged public var color: Int64
    @NSManaged public var current: Int64
    @NSManaged public var target: Int64
    @NSManaged public var days: Int64

}
