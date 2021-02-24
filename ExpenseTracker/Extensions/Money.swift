//
//  Money.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation


typealias Money = Double

extension Money {
    
    func formatAmount() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        
        let formattedAmount = formatter.string(from: NSNumber(value: self))!
        return "$\(formattedAmount)"
    }
}
