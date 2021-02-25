//
//  HeaderView.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet var totalBalance: UILabel!
    @IBOutlet var incomeBalance: UILabel!
    @IBOutlet var expenseBalance: UILabel!
    @IBOutlet var textBalance: UILabel!
    @IBOutlet var incomeText: UILabel!
    @IBOutlet var expenseText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelSpacing(label: textBalance, text: "BALANCE")
        labelSpacing(label: incomeText, text: "INCOME")
        labelSpacing(label: expenseText, text: "EXPENSE")
    }
    
    func labelSpacing(label: UILabel, text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1.7), range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
    }
    
    
    
    
    func setup(totalBalance: Money, incomeBalance: Money, expenseBalance: Money) {
        
        self.totalBalance.text = totalBalance.formatAmount()
        self.incomeBalance.text = incomeBalance.formatAmount()
        self.expenseBalance.text = expenseBalance.formatAmount()
    }
}


