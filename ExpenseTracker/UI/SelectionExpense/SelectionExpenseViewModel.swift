//
//  SelectionExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 01/03/2021.
//

import Foundation
import UIKit

protocol SelectionExpenseViewModelDelegate {
    func getData(start: Date?, end: Date?, categories: [Category]?)
    func showSelectionFilters()
}

class SelectionExpenseViewModel: ViewModel, SelectionExpenseViewModelDelegate {
    
    var coordinator: SelectionExpenseCoordinatorDelegate
    var selectionExpenseView: SelectionExpenseView
    
    init(coordinator: SelectionExpenseCoordinatorDelegate, selectionExpenseView: SelectionExpenseView) {
        self.coordinator = coordinator
        self.selectionExpenseView = selectionExpenseView
    }
    
    func getData(start: Date?, end: Date?, categories: [Category]?) {
        let startDate = start ?? Date().startOfMonth
        let endDate = end ?? Date().endOfMonth
        let request = Item.fetchItems(start: startDate, end: endDate, categories: categories)
        let items = try? context.fetch(request)
        
        let categories = items?.map { (item) -> Category in
            item.categoryId
        }
        
        if let categories = categories {
            var categoryItems = [Category: [Item]]()
            let uniqueCategories = Array(Set(categories))
            for category in uniqueCategories {
                let filterItems = items?.filter({ (item) -> Bool in
                    item.categoryId == category
                })
                categoryItems[category] = filterItems
            }            
            selectionExpenseView.showData(categories: uniqueCategories, items: categoryItems)
        }
        
    }

    func showSelectionFilters() {
        coordinator.navigateToSelectFilters()
    }
}
