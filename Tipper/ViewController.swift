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
        
        // perform loading here
        loadData()
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
    
    // helper methods
    func saveData() {
        //print("saveData attempt")
        UserDefaults.standard.set(billAmountTextField.text, forKey: "billAmount")
        UserDefaults.standard.set(Date(), forKey: "lastRunTime")
        UserDefaults.standard.synchronize() // force to update before closing
    }
    
    func loadData() {
        // check when the app was closed when last run
        //print("right before lastRunDate")
        if let lastRunDate = UserDefaults.standard.object(forKey: "lastRunTime") as? Date {
            //print("successfully retrieved date")
            let interval = NSDateInterval(start: lastRunDate, end: Date())
            if interval.duration < 600 { // less than 10 minutes pass since last closed
                billAmountTextField.text = UserDefaults.standard.string(forKey: "billAmount") ?? ""
            } else {
                //print("duration longer")
            }
        }
    }
    
}

