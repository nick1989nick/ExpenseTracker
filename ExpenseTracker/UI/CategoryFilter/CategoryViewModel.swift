//
//  CategoryViewModel.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 02/03/2021.
//

import Foundation
import UIKit

protocol CategoryViewModelDelegate {
    func getCategories()
}

class CategoryViewModel: ViewModel, CategoryViewModelDelegate {
 
    var categoryView: CategoryFilterView
    
    init(categoryView: CategoryFilterView) {
        self.categoryView = categoryView
    }
    
    func getCategories() {
        let categoryRequest = Category.fetchCategories()
        let categories = try? context.fetch(categoryRequest)
        if let categories = categories {
            categoryView.showCategories(categories: categories)
        }      
    }

}
