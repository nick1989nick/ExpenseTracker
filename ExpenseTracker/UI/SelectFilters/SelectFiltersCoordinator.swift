//
//  SelectFiltersCoordinator.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 02/03/2021.
//

import Foundation
import UIKit

protocol SelectFiltersCoordinatorDelegate: CoordinatorDelegate {
    func navigateToCategoryFilter(selectedCategories: [Category])
}

class SelectFiltersCoordinator: Coordinator, SelectFiltersCoordinatorDelegate {
    func navigateToCategoryFilter(selectedCategories: [Category]) {
        let destinationController: CategoryFilterViewController? = viewController?.instantiateFromStoryboard(viewController: "CategoryFilterViewController")
        if let destinationController = destinationController {
            destinationController.categoriesFilterProtocol = viewController as! CategoriesFilterProtocol
            destinationController.selectedCategories = selectedCategories
            destinationController.modalPresentationStyle = .formSheet
            viewController?.present(destinationController, animated: true, completion: nil)
        }
    }
 
}
