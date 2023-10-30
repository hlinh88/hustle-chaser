//
//  Expense+CoreDataProperties.swift
//  
//
//  Created by Hoang Linh Nguyen on 29/10/2023.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var source: String?
    @NSManaged public var amount: Int64
    @NSManaged public var type: Bool
    @NSManaged public var color: Int64

}
