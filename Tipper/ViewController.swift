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
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipAmountSlider: UISlider!
    @IBOutlet weak var totalLabel: UILabel!
    
    var lastDefaultTip = "3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Launch app and start typing
        billAmountTextField.becomeFirstResponder()
        
        // Label & textfield alignments
        billAmountTextField.textAlignment = .right
        tipAmountLabel.textAlignment = .right
        totalLabel.textAlignment = .right
        
        // keyboard type
        billAmountTextField.keyboardType = .decimalPad
        
        // perform loading here
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // If there is a change in the default tip amount, update the slider and all the labels, and remember this tip percent
        super.viewDidAppear(animated)
        if let defaultTip = UserDefaults.standard.string(forKey: "tipPicker") {
            if lastDefaultTip != defaultTip {
                tipAmountSlider.setValue(15+Float(defaultTip)!, animated: true)
                updateLabels()
                lastDefaultTip = defaultTip
            }
        }
    }
    

    @IBAction func onTap(_ sender: Any) {
        // dismiss keyboard when background tapped
        billAmountTextField.resignFirstResponder()
    }
    @IBAction func calculateTip(_ sender: Any) {
        updateLabels()
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
    
    func updateLabels() {
        // Get initial bill amount and calculate tips
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Calculate tip and total
        let tip = bill * Double(tipAmountSlider.value/100)
        let total = bill + tip
        
        // Update the tip percentage, the tip amount and the total labels
        let formattedPercentage = String(format: "%.2f", tipAmountSlider.value)
        tipPercentageLabel.text = "Tips (" + formattedPercentage + "%)"
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

