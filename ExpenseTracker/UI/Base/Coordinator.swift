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
    
    let viewController: BaseViewController
    
    func pop() {
        
    }
    
}
