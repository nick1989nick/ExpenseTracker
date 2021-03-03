//
//  SelectFiltersViewController.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 01/03/2021.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

protocol SelectFiltersView {
    func showApplyFilters(selectedDateFrom: Date, selectedDateTo: Date, selectedCategories: [Category])
    func showError(message: String)
}

protocol CategoriesFilterProtocol {
    func categoriesSelected(categories: [Category])
}

class SelectFiltersViewController: BaseViewController, SelectFiltersView, CategoriesFilterProtocol {
   
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var dateFromView: UIView!
    @IBOutlet var dateToView: UIView!
    @IBOutlet var categoryButton: UIButton!
    
    var dateFrom: MDCOutlinedTextField?
    var dateTo: MDCOutlinedTextField?
    var viewModel: SelectFiltersViewModelDelegate?
    var filterProtocol: FilterDelegate?
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SelectFiltersViewModel(selectFiltersView: self, coordinator: SelectFiltersCoordinator(viewController: self))
        
        setupDateToTextView()
        setupDateFromTextView()
       
    }
    
    @IBAction func onApplyButtonTapped() {
        viewModel?.applyFilters()
    }
    
    func categoriesSelected(categories: [Category]) {
        viewModel?.selectedCategories = categories
    }

    
    func showApplyFilters(selectedDateFrom: Date, selectedDateTo: Date, selectedCategories: [Category]) {
        filterProtocol?.apply(category: selectedCategories, dateFrom: selectedDateFrom, dateTo: selectedDateTo)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupDateFromTextView() {
        let datePicker = UIDatePicker()
        datePicker.setDate(Date(), animated: false)
        datePicker.addTarget(self, action: #selector(onDateFromPickerValueChange(sender:)), for: .valueChanged)
        datePicker.datePickerMode = .dateAndTime
        datePicker.maximumDate = Date()
        
        dateFrom = MDCOutlinedTextField(frame: dateFromView.frame)
        guard let dateFrom = dateFrom else {
            return
        }
        dateFrom.sizeToFit()
        dateFrom.autocapitalizationType = .none
        dateFrom.placeholder = "DateFrom"
        dateFrom.label.text = "DateFrom"
        dateFrom.isUserInteractionEnabled = true
        dateFrom.setOutlineColor(.gray, for: .normal)
        dateFrom.setOutlineColor(.gray, for: .editing)
        dateFrom.inputView = datePicker
        dateFromView.addConstrained(subview: dateFrom)
    }
    
    @objc func onDateFromPickerValueChange(sender: Any) {
        let picker = dateFrom?.inputView as? UIDatePicker
        if let picker = picker {
            viewModel?.selectedDateFrom = picker.date
            self.dateFrom?.text = "\(picker.date.toString(format: "MMM dd, yyyy")) at \(picker.date.toString(format: "hh:mm a")) "
        }
    }
    
    func setupDateToTextView() {
        let datePicker = UIDatePicker()
        datePicker.setDate(Date(), animated: false)
        datePicker.addTarget(self, action: #selector(onDateToPickerValueChange(sender:)), for: .valueChanged)
        datePicker.datePickerMode = .dateAndTime
        datePicker.maximumDate = Date()
        
        dateTo = MDCOutlinedTextField(frame: dateToView.frame)
        guard let dateTo = dateTo else {
            return
        }
        dateTo.sizeToFit()
        dateTo.autocapitalizationType = .none
        dateTo.placeholder = "DateTo"
        dateTo.label.text = "DateTo"
        dateTo.isUserInteractionEnabled = true
        dateTo.setOutlineColor(.gray, for: .normal)
        dateTo.setOutlineColor(.gray, for: .editing)
        dateTo.inputView = datePicker
        dateToView.addConstrained(subview: dateTo)
    }
    
    @objc func onDateToPickerValueChange(sender: Any) {
        let picker = dateTo?.inputView as? UIDatePicker
        if let picker = picker {
            viewModel?.selectedDateTo = picker.date
            self.dateTo?.text = "\(picker.date.toString(format: "MMM dd, yyyy")) at \(picker.date.toString(format: "hh:mm a")) "
        }
    }
    
    @IBAction func onCategoryButtonTapped() {
        viewModel?.showCategoryFilters()
    }
    
    @IBAction func onBackArrowTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


