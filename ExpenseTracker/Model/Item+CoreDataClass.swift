//
//  Item+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation
import CoreData

@objc class Item: NSManagedObject {
    
    @nonobjc public class func fetchItemsForCurrentMonth() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        let date = Date()
        request.predicate = NSPredicate(format: "date >= %@ and date <= %@", date.startOfMonth as NSDate, date.endOfMonth as NSDate)
        
        return request
    }
    
    class func getEntityDescription(context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Item", in: context)!
    }
    
    class func insert(context: NSManagedObjectContext, amount: Double, date: Date, name: String, type: String, categoryId: Category) {
        let item = Item(entity: getEntityDescription(context: context), insertInto: context)
        item.name = name
        item.date = date
        item.type = type
        item.amount = amount
        item.categoryId = categoryId
        try? context.save()
        
    }
    
    class func fetchItems(start: Date, end: Date, categories: [Category]?) -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        
        if let categories = categories, !categories.isEmpty {
            request.predicate = NSPredicate(format: "date >= %@ and date <= %@ and categoryId in (%@)", start as NSDate, end as NSDate, categories)
        } else {
            request.predicate = NSPredicate(format: "date >= %@ and date <= %@", start as NSDate, end as NSDate)
        }
        
        return request
    }
    
    
    @NSManaged public var amount: Double
    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var categoryId: Category
}
