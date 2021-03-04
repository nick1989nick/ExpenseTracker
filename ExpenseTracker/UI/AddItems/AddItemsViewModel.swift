//
//  AddItemsViewModel.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 24/02/2021.
//

import Foundation
import UIKit

protocol AddItemsViewModelDelegate {
    var selectedCategory: Category? { get set }
    var selectedDate: Date? {get set }
    func getCategories()
    func save(name: String?, amount: String?)
}

class AddItemsViewModel: ViewModel, AddItemsViewModelDelegate {
    
    var selectedCategory: Category?
    var selectedDate: Date?
    var addItemsView: AddItemsView
    var coordinator: AddItemsCoordinatorDelegate
    
    init(addItemsView: AddItemsView, coordinator: AddItemsCoordinatorDelegate) {
        self.addItemsView = addItemsView
        self.coordinator = coordinator
    }
    
    func getCategories() {
        let request = Category.fetchCategories()
        let categories = try? context.fetch(request)
        if let categories = categories {
            addItemsView.showCategories(categories: categories)
        }
    }
    
    func save(name: String?, amount: String?) {
        guard let name = name, let amount = amount, let amountValue = Double(amount), let category = selectedCategory, let date = selectedDate else {
            addItemsView.showAlert(title: "Error", text: "All fields are mandatory")
            return
        }
        
        var type = "Expense"
        if category.name == "Income" {
            type = "Income"
        }
        Item.insert(context: context, amount: amountValue, date: date, name: name, type: type, categoryId: category)
        
        selectedDate = nil
        selectedCategory = nil
        
        addItemsView.showItemSaved()
    }

}
