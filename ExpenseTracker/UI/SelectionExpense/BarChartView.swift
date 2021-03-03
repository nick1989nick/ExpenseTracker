//
//  BarChartView.swift
//  ExpenseTracker
//
//  Created by Nikola Jurkovic on 02/03/2021.
//

import Foundation
import UIKit
import Charts

class BarChartViewHeader: BarChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xAxis.granularity = 1.0
        xAxis.drawGridLinesEnabled = false
        xAxis.avoidFirstLastClippingEnabled = true
    
        pinchZoomEnabled = false
        scaleXEnabled = false
        scaleYEnabled = false
        xAxis.labelTextColor = .white
        leftAxis.labelTextColor = .white
        
        legend.enabled = false
        rightAxis.enabled = false
        rightAxis.drawGridLinesEnabled = false
        backgroundColor = UIColor(named: "darkBlue")!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(dictionary: [Category:[Item]]) {
        var dataEntries: [BarChartDataEntry] = []
        var count = 0
        var labelCategories = [String]()
        var colors = [UIColor]()
        for (category, items) in dictionary {
            labelCategories.append(category.name)
            let totalAmount = items.reduce(0.0) { (result, item) -> Double in
                result + item.amount
            }
            let entry = BarChartDataEntry(x: Double(count), y: totalAmount, data: category.name)
            dataEntries.append(entry)
            count = count + 1
            
            if category.name == "Income" {
                colors.append(UIColor(named: "lightGreen")!)
            } else {
                colors.append(UIColor(named: "lightOrange")!)
            }
        }
        
        xAxis.valueFormatter = IndexAxisValueFormatter(values: labelCategories)
        xAxis.granularity = 1.0
        xAxis.granularityEnabled = true
        leftAxis.axisMinimum = 0.0
        xAxis.xOffset = 1
        xAxis.labelPosition = .bottom
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.colors = colors
        let chartData = BarChartData(dataSet: chartDataSet)
        data = chartData
    }
    

   
}
