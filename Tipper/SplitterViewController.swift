//
//  SplitterViewController.swift
//  Tipper
//
//  Created by SB on 7/29/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class SplitterViewController: UITableViewController {
    
    @IBOutlet weak var howManySplitLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var firstCellPeopleLabel: UILabel!
    @IBOutlet weak var firstCellAmountLabel: UILabel!
    @IBOutlet weak var secondCellPeopleLabel: UILabel!
    @IBOutlet weak var secondCellAmountLabel: UILabel!
    @IBOutlet weak var thirdCellPeopleLabel: UILabel!
    @IBOutlet weak var thirdCellAmountLabel: UILabel!
    
    var totalAmount = 0.00
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        nf.usesGroupingSeparator = true
        nf.groupingSeparator = Locale.current.groupingSeparator
        return nf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // make table view unscrollable
        tableView.isScrollEnabled = false
    }
    
    @IBAction func stepperTapped(_ sender: Any) {
        howManySplitLabel.text = String(format: "%.0f", stepper.value)
        
        firstCellPeopleLabel.text = String(format: "%.0f", stepper.value-1)
        secondCellPeopleLabel.text = String(format: "%.0f", stepper.value)
        thirdCellPeopleLabel.text = String(format: "%.0f", stepper.value+1)
        
        updateAmountLabels()
    }
    
    func updateAmountLabels() {
        let localCurrency = Locale.current.currencySymbol
        
        let firstSplitAmount = totalAmount/(stepper.value-1)
        firstCellAmountLabel.text = localCurrency! + numberFormatter.string(from: firstSplitAmount as NSNumber)!
        
        let secondSplitAmount = totalAmount/stepper.value
        secondCellAmountLabel.text = localCurrency! + numberFormatter.string(from: secondSplitAmount as NSNumber)!
        
        let thirdSplitAmount = totalAmount/(stepper.value+1)
        thirdCellAmountLabel.text = localCurrency! + numberFormatter.string(from: thirdSplitAmount as NSNumber)!
    }
    
}
