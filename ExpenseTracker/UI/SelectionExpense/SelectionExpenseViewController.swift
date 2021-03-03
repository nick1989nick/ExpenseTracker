//
//  SelectionExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 01/03/2021.
//

import Foundation
import UIKit

protocol FilterDelegate {
    func apply(category: [Category], dateFrom: Date, dateTo: Date)
}

protocol SelectionExpenseView {
    func showData(categories: [Category], items: [Category:[Item]])
}

class SelectionExpenseViewController: BaseViewController, SelectionExpenseView, FilterDelegate {
  
  
    @IBOutlet var tableView: UITableView!
    
    var categories = [Category]()
    var items = [Category : [Item]]()
    var viewModel: SelectionExpenseViewModelDelegate?
    var headerView: BarChartViewHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SelectionExpenseViewModel(coordinator:SelectionExpenseCoordinator(viewController: self), selectionExpenseView: self)

        tableView.delegate = self
        tableView.dataSource = self
        headerView = BarChartViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 270))
        tableView.tableHeaderView = headerView
        viewModel?.getData(start: Date().startOfMonth, end: Date().endOfMonth, categories: nil)
        
    }
    
    @IBAction func onSelectCategorisTapped() {
        viewModel?.showSelectionFilters()
    }

    func showData(categories: [Category], items: [Category:[Item]]) {
        self.categories = categories
        self.items = items
        tableView.reloadData()
        headerView?.setup(dictionary: items)
    }
    
    func apply(category: [Category], dateFrom: Date, dateTo: Date) {
        viewModel?.getData(start: dateFrom, end: dateTo, categories: category)
    }

}

extension SelectionExpenseViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        let item = items[category]
        if let item = item {
            return item.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionExpenseCell") as! SelectionExpenseCell
        let category = categories[indexPath.section]
        let item = items[category]![indexPath.row]
        cell.name.text = item.name
        cell.selectionStyle = .none
        if item.type == "Expense" {
            cell.amount.textColor = UIColor(named: "redExpense")
        } else {
            cell.amount.textColor = UIColor(named: "greenIncome")
        }
        cell.amount.text = (item.amount as Money).formatAmount()
        cell.date.text = "\(item.date.toString(format: "MMM dd, yyyy")) at \(item.date.toString(format: "hh:mm a"))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: SelectionHeaderView = .fromNib()
        let category = categories[section]
        let item = items[category]!
        
        let income = item.filter { $0.type == "Income" }.reduce(0.0) { (result, item) -> Double in
            result + item.amount
        }
        
        let expenses = item.filter { $0.type == "Expense" }.reduce(0.0) { (result, item) -> Double in
            result + item.amount
        }
        
        let total: Money = income - expenses
        
        header.name.text = category.name
        header.amount.text = total.formatAmount()
        
        return header
    }

}

class SelectionExpenseCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var amount: UILabel!
}
