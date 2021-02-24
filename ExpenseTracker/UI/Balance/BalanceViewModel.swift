//
//  BalanceViewModel.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation
import UIKit
import CoreData

protocol BalanceViewModelDelegate: AnyObject {
    func getData()
}

class BalanceViewModel: ViewModel, BalanceViewModelDelegate {
    
    weak var balanceViewDelegate: BalanceViewControllerView?
    
    init(balanceViewDelegate: BalanceViewControllerView) {
        self.balanceViewDelegate = balanceViewDelegate
    }
    
    func getData() {
        let request = Item.fetchItemsForCurrentMonth()
        do {
            let items = try context.fetch(request)
            if items.isEmpty {
                balanceViewDelegate?.showEmptyView()
            } else {
                balanceViewDelegate?.showData(item: items)
            }
        } catch {
            balanceViewDelegate?.showEmptyView()
        }
    }

}
