//
//  Coordinator.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation
import UIKit

protocol CoordinatorDelegate {
    
    func pop()
}

class Coordinator: CoordinatorDelegate {
    
    weak var viewController: BaseViewController?
    
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    func pop() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func present(viewController: BaseViewController) {
        self.viewController?.present(viewController, animated: true, completion: nil)
    }
}
