//
//  Date+Formatters.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getDateFor(years: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: years, to: Date())
    }
    
}
