//
//  CategoryFilter.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 02/03/2021.
//

import Foundation
import UIKit

protocol CategoryFilterView {
    func showCategories(categories: [Category])
}

class CategoryFilterViewController: BaseViewController, CategoryFilterView {
    @IBOutlet var tableView: UITableView!
    
    var categories = [Category]()
    var selectedCategories = [Category]()
    var viewModel: CategoryViewModelDelegate?
    var categoriesFilterProtocol: CategoriesFilterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CategoryViewModel(categoryView: self)
        viewModel?.getCategories()
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func showCategories(categories: [Category]) {
        self.categories = categories
    }
    
    @IBAction func onSaveButtonTapped() {
        categoriesFilterProtocol?.categoriesSelected(categories: selectedCategories)
        dismiss(animated: true, completion: nil)
    }
}

extension CategoryFilterViewController: UITableViewDelegate {
    
}

extension CategoryFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryFilterCell") as! CategoryFilterCell
        let category = categories[indexPath.row]
        cell.selectionStyle = .none
        cell.categoryName.text = category.name
        cell.checkbox.isSelected = selectedCategories.contains(category)
        cell.onCheckboxButtonClicked = { [unowned self] isSelected in
            if isSelected {
                self.selectedCategories.append(category)
            } else {
                if let index = selectedCategories.index(of: category) {
                    self.selectedCategories.remove(at: index)
                }
            }
        }
        return cell
    }
    
    
}

class CategoryFilterCell: UITableViewCell {
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var checkbox: UIButton!
    
    var onCheckboxButtonClicked: (_ isSelected: Bool) -> Void = {_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkbox.setImage(UIImage(named: "unChecked"), for: .normal)
        checkbox.setImage(UIImage(named: "checked"), for: .selected)
        
    }
    
    @IBAction func onCheckboxTapped() {
        checkbox.isSelected = !checkbox.isSelected
        onCheckboxButtonClicked(checkbox.isSelected)
    }
}
