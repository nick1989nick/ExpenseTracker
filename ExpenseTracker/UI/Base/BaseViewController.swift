//
//  BaseViewController.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation
import UIKit

protocol BaseView {
    
    var coordinator: CoordinatorDelegate? { get }
}

class BaseViewController: UIViewController {
    
}

