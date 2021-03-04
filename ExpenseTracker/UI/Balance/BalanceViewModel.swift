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
    func deleteItem(item: Item)
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
                balanceViewDelegate?.showHeaderValues(income: 0.0, expense: 0.0, balance: 0.0)
                balanceViewDelegate?.showEmptyView()
            } else {
                let income = items.filter { $0.type == "Income" }.reduce(0.0) { (result, item) -> Double in
                    result + item.amount
                }
                
                let expenses = items.filter { $0.type == "Expense" }.reduce(0.0) { (result, item) -> Double in
                    result + item.amount
                }
                
                let balance = income - expenses
                balanceViewDelegate?.showHeaderValues(income: income, expense: expenses, balance: balance)
                balanceViewDelegate?.showData(item: items)
            }
        } catch {
            balanceViewDelegate?.showHeaderValues(income: 0.0, expense: 0.0, balance: 0.0)
            balanceViewDelegate?.showEmptyView()
        }
    }
    
    func deleteItem(item: Item) {
        context.delete(item)
        try? context.save()
        getData()
    }

}
