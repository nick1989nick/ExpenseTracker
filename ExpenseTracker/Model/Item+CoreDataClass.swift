//
//  Item+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation
import CoreData

@objc class Item: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        let date = Date()
        request.predicate = NSPredicate(format: "date >= %@ and date <= %@", date.startOfMonth as NSDate, date.endOfMonth as NSDate)
        
        return request
    }
    
    class func getEntityDescription(context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Item", in: context)!
    }
    
    @NSManaged public var amount: Double
    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var type: String
    
}
