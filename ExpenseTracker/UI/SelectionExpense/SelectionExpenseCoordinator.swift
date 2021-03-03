//
//  SelectionExpenseCoordinator.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 01/03/2021.
//

import Foundation
import UIKit


protocol SelectionExpenseCoordinatorDelegate: CoordinatorDelegate {
    func navigateToSelectFilters()
}

class SelectionExpenseCoordinator: Coordinator, SelectionExpenseCoordinatorDelegate {
    func navigateToSelectFilters() {
        let destinationController: SelectFiltersViewController? = viewController?.instantiateFromStoryboard(viewController: "SelectFiltersViewController")
        if let destinationController = destinationController {
            destinationController.filterProtocol = viewController as! FilterDelegate
            destinationController.modalPresentationStyle = .fullScreen
            viewController?.present(destinationController, animated: true, completion: nil)
        }
    }
}
