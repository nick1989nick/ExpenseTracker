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

class BaseViewController: UIViewController, BaseView {
    
    public var coordinator: CoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator = Coordinator(viewController: self)
    }
    
    func instantiateFromStoryboard<T>(_ storyboard: String = "Main", viewController: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewController)
        return viewController as! T
    }
}

