//
//  ViewController.swift
//  Tipper
//
//  Created by SB on 7/14/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Launch app and start typing
        billAmountTextField.becomeFirstResponder()
        
        // Label & textfield alignments
        billAmountTextField.textAlignment = .right
        tipPercentageLabel.textAlignment = .right
        totalLabel.textAlignment = .right
        
        // keyboard type
        billAmountTextField.keyboardType = .decimalPad
    }

    @IBAction func onTap(_ sender: Any) {
        // dismiss keyboard when background tapped
        billAmountTextField.resignFirstResponder()
    }
    @IBAction func calculateTip(_ sender: Any) {
        // Get initial bill amount and calculate tips
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        
        // Calculate tip and total
        let tip = bill * tipPercentages[tipAmountSegmentedControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Update the tip and total labels
        tipPercentageLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

