//
//  Category+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation
import CoreData

@objc class Category: NSManagedObject {
    
    
    @nonobjc public class func fetchCategories() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
    
    class func getEntityDescription(context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Category", in: context)!
    }
    
    class func insert(context: NSManagedObjectContext, id: Int16, name: String) {
        let category = Category(entity: getEntityDescription(context: context), insertInto: context)
        category.id = id
        category.name = name
        try? context.save()
    }
    
    @NSManaged public var id: Int16
    @NSManaged public var name: String
}
