//
//  EmptyView.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 23/02/2021.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet var emptyText: UILabel!
    
    
    func setup(text: String) {
        emptyText.text = text
    }
}
