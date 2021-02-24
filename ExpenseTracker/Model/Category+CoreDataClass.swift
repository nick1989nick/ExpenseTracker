//
//  Category+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation
import CoreData

@objc class Category: NSManagedObject {
    
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
    
    class func getEntityDescription(context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Category", in: context)!
    }
    
    @NSManaged public var id: String
    @NSManaged public var name: String
}
