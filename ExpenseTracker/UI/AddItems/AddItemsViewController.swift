//
//  AddItemsViewController.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 24/02/2021.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields


protocol AddItemsView {
    func showCategories(categories: [Category])
    func showAlert(title: String, text: String)
    func showItemSaved()
}

class AddItemsViewController: BaseViewController, AddItemsView, UITextFieldDelegate {
   
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var nameView: UIView!
    @IBOutlet var dateView: UIView!
    @IBOutlet var amountView: UIView!
    
    
    var name: MDCOutlinedTextField?
    var date: MDCOutlinedTextField?
    var amount: MDCOutlinedTextField?
    var categories: [Category] = [] {
        didSet {
            categoryPicker.reloadAllComponents()
        }
    }
    let categoryPicker = UIPickerView()
   
   
    var viewModel: AddItemsViewModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AddItemsViewModel(addItemsView: self, coordinator: AddItemsCoordinator(viewController: self))
        categoryTextField.inputView = categoryPicker
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        setupNameTextView()
        setupDateTextView()
        setupAmoutTextView()
        addDoneButtonOnKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.getCategories()
        categoryPicker.becomeFirstResponder()
    }
    
    func showCategories(categories: [Category]) {
        self.categories = categories
        viewModel?.selectedCategory = categories[0]
        categoryTextField.text = categories[0].name
    }
    
    
    @IBAction func onSaveTapped() {
        viewModel?.save(name: name?.text, amount: amount?.text)
    }
    
    func setupNameTextView() {
        name = MDCOutlinedTextField(frame: nameView.frame)
        guard let name = name else {
            return
        }
        name.sizeToFit()
        name.autocapitalizationType = .none
        name.placeholder = categoryTextField.text
        name.label.text = "Name"
        name.autocorrectionType = .no
        name.setOutlineColor(.gray, for: .normal)
        name.setOutlineColor(.gray, for: .editing)
        nameView.addConstrained(subview: name)
        
    }
    
    func setupDateTextView() {
        let datePicker = UIDatePicker()
        datePicker.setDate(Date(), animated: false)
        datePicker.addTarget(self, action: #selector(onDatePickerValueChange(sender:)), for: .valueChanged)
        datePicker.datePickerMode = .dateAndTime
        datePicker.maximumDate = Date()
        
        date = MDCOutlinedTextField(frame: dateView.frame)
        guard let date = date else {
            return
        }
        date.sizeToFit()
        date.autocapitalizationType = .none
        date.placeholder = "Date"
        date.label.text = "Date"
        date.isUserInteractionEnabled = true
        date.setOutlineColor(.gray, for: .normal)
        date.setOutlineColor(.gray, for: .editing)
        date.inputView = datePicker
        dateView.addConstrained(subview: date)
    }
    
    @objc func onDatePickerValueChange(sender: Any) {
        let picker = date?.inputView as? UIDatePicker
        if let picker = picker {
            viewModel?.selectedDate = picker.date
            self.date?.text = "\(picker.date.toString(format: "MMM dd, yyyy")) at \(picker.date.toString(format: "hh:mm a")) "
        }
    }
    
    func setupAmoutTextView() {
        amount = MDCOutlinedTextField(frame: amountView.frame)
        guard let amount = amount else {
            return
        }
        amount.sizeToFit()
        amount.autocapitalizationType = .none
        amount.placeholder = "Amount"
        amount.label.text = "Amount"
        amount.keyboardType = .decimalPad
        amount.delegate = self
        
        amount.setOutlineColor(.gray, for: .normal)
        amount.setOutlineColor(.gray, for: .editing)
        amountView.addConstrained(subview: amount)
        
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .black
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        if let name = name, let amount = amount {
            name.inputAccessoryView = doneToolbar
            amount.inputAccessoryView = doneToolbar
            categoryTextField.inputAccessoryView = doneToolbar
        }
        
    }
    
    @objc func doneButtonAction() {
        if let name = name, let amount = amount {
            name.resignFirstResponder()
            amount.resignFirstResponder()
            categoryTextField.resignFirstResponder()
        }
    }
    
    @objc func donePicker(sender: Any) {
        categoryTextField.resignFirstResponder()
    }
    
    func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showItemSaved() {
        showAlert(title: "Well done", text: "Item has successfully saved")
        name?.text = ""
        amount?.text = ""
        date?.text = ""
        categoryTextField.text = categories[0].name
        viewModel?.selectedCategory = categories[0]
        categoryPicker.reloadAllComponents()

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        let array = newString.components(separatedBy: ",")
        
        if arrayOfString.count > 2 || array.count > 1 {
            return false
        }
        if arrayOfString.count > 1 && arrayOfString[1].count > 2 {
            return false
        }
        return true
    }
    
    
}

extension AddItemsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = categories[row].name
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        let category = categories[row]
        viewModel?.selectedCategory = category
        categoryTextField.text = category.name
       
    }
}
