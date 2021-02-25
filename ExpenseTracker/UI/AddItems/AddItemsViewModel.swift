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
    var selectedType: String? {get set }
    var selectedDate: Date? {get set }
    func getCategories()
    func save(name: String?, amount: String?)
}

class AddItemsViewModel: ViewModel, AddItemsViewModelDelegate {
    
    var selectedCategory: Category?
    var selectedType: String?
    var selectedDate: Date?
    let addItemsView: AddItemsView
    let coordinator: AddItemsCoordinatorDelegate
    
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
        guard let name = name, let amount = amount, let amountValue = Double(amount), let category = selectedCategory, let type = selectedType, let date = selectedDate else {
            addItemsView.showAlert(title: "Error", text: "All fields are mandatory")
            return
        }
        Item.insert(context: context, amount: amountValue, date: date, name: name, type: type, categoryId: category)
        
        selectedDate = nil
        selectedType = nil
        selectedCategory = nil
        
        addItemsView.showItemSaved()
    }

}
