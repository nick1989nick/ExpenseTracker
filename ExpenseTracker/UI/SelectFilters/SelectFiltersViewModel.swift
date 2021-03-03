//
//  SelectFiltersViewModel.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 01/03/2021.
//

import Foundation
import UIKit

protocol SelectFiltersViewModelDelegate {
    var selectedDateFrom: Date? { get set }
    var selectedDateTo: Date? { get set }
    var selectedCategories: [Category] { get set }
    func applyFilters()
    func showCategoryFilters()
}

class SelectFiltersViewModel: ViewModel, SelectFiltersViewModelDelegate {
  
    var selectedCategories: [Category] = []
    var selectedDateFrom: Date?
    var selectedDateTo: Date?
    var selectFiltersView: SelectFiltersView?
    var coordinator: SelectFiltersCoordinatorDelegate?

    
    init(selectFiltersView: SelectFiltersView, coordinator: SelectFiltersCoordinatorDelegate) {
        self.selectFiltersView = selectFiltersView
        self.coordinator = coordinator
    }
    
    func applyFilters() {
        if let selectedDateTo = selectedDateTo, let selectedDateFrom = selectedDateFrom {
            selectFiltersView?.showApplyFilters(selectedDateFrom: selectedDateFrom, selectedDateTo: selectedDateTo, selectedCategories: selectedCategories)
        } else {
            selectFiltersView?.showError(message: "Date fields are mandatory, please fill the fields!")
        }
    
    }
    
    func showCategoryFilters() {
        coordinator?.navigateToCategoryFilter(selectedCategories: selectedCategories)
    }
    
}
