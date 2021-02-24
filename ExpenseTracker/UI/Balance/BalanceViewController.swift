//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import UIKit

protocol BalanceViewControllerView: AnyObject {
    func showData(item: [Item])
    func showEmptyView()
}

class BalanceViewController: UIViewController, BalanceViewControllerView {
  
    @IBOutlet var tableView: UITableView!
    
    var items = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    var headerView: HeaderView?
    var viewModel: BalanceViewModelDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        viewModel = BalanceViewModel(balanceViewDelegate: self)
        headerView = .fromNib()
        tableView.tableHeaderView = headerView
        headerView?.setup(totalBalance: 0.0, incomeBalance: 0.0, expenseBalance: 0.0)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.getData()
    }
    
    func showData(item: [Item]) {
        view.subviews.forEach { (view) in
            if view === EmptyView.self {
                view.removeFromSuperview()
            }
        }
        self.items = item
    }
    
    func showEmptyView() {
        var hasEmptyView = false
        view.subviews.forEach { (view) in
            if view === EmptyView.self {
                hasEmptyView = true
            }
        }
        if !hasEmptyView {
            let emptyView: EmptyView = .fromNib()
            emptyView.setup(text: "Start by adding some income or expense ")
            view.addConstrained(subview: emptyView)
        }
    }

}


extension BalanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        let item = items[indexPath.row]
        cell.name.text = item.name
        cell.amount.text = (item.amount as Money).formatAmount()
        cell.date.text = item.date.toString(format: "MMM dd, yyyy at hh:mm a")
        return cell
    }

}



