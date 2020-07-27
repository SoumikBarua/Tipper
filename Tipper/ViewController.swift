//
//  ViewController.swift
//  Tipper
//
//  Created by SB on 7/14/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipAmountSlider: UISlider!
    @IBOutlet weak var totalLabel: UILabel!
    
    var lastDefaultTip = "3"
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
        // Do any additional setup after loading the view.
        // Launch app and start typing
        billAmountTextField.becomeFirstResponder()
        
        // Label & textfield alignments
        billAmountTextField.textAlignment = .right
        tipAmountLabel.textAlignment = .right
        totalLabel.textAlignment = .right
        
        // keyboard type & delegate
        billAmountTextField.keyboardType = .decimalPad
        billAmountTextField.delegate = self
        
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
        UserDefaults.standard.set(Locale.current.decimalSeparator, forKey: "lastDecimalSeparator")
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
                updateTextField()
            } else {
                //print("duration longer")
            }
        }
    }
    
    func updateLabels() {
        // Get initial bill amount and calculate tips
        var bill = 0.00
        if let billText = billAmountTextField.text, let number = numberFormatter.number(from: billText) {
            bill = number.doubleValue
        }

        // Calculate tip and total
        let tip = bill * Double(tipAmountSlider.value/100)
        let total = bill + tip
        
        // Update the tip percentage, the tip amount and the total labels
        let formattedPercentage = String(format: "%.2f", tipAmountSlider.value)
        tipPercentageLabel.text = "Tips (" + formattedPercentage + "%)"
        
        let localCurrency = Locale.current.currencySymbol
        tipAmountLabel.text = localCurrency! + numberFormatter.string(from: tip as NSNumber)!
        totalLabel.text = localCurrency! + numberFormatter.string(from: total as NSNumber)!
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Prevent entry of leading zeros or leading decimal separators
        if billAmountTextField.text == "" {
            if string[string.startIndex] == "0" || string[string.startIndex] == Character(Locale.current.decimalSeparator!) {
                return false
            } else {
                return true
            }
        } else {
            // Prevent entry of multiple decimal separators, ensure this based on locale-specific decimal separator
            // also, prevent entry of more than two digits after the decimal
            
            let currentLocale = Locale.current
            let decimalSeparator = currentLocale.decimalSeparator ?? "."
            
            let existingTextHasDecimalSeparator = billAmountTextField.text?.range(of: decimalSeparator)
            let replaceTextHasDecimalSeparator = string.range(of: decimalSeparator)
            
            let fractionalParts = billAmountTextField.text?.components(separatedBy: ".") ?? []
            
            if existingTextHasDecimalSeparator != nil, replaceTextHasDecimalSeparator != nil {
                return false
            } else if fractionalParts.count == 2 {
                // when there is already two digits after decimal and another digit is about to be added
                if fractionalParts[1].count == 2 && string.count == 1 {
                    return false
                } else {
                    return true
                }
            } else {
                return true
            }
        }
    }
    
    func updateTextField() {
        // Check if the region settings has changed during a run
        let lastDecimalSeparator = UserDefaults.standard.string(forKey: "lastDecimalSeparator") ?? "."
        if lastDecimalSeparator != Locale.current.decimalSeparator {
            if let currentText = billAmountTextField.text {
                let oldChar = Character(lastDecimalSeparator)
                let newChar = Character(Locale.current.decimalSeparator!)
                var result = String()
                for char in currentText {
                    if char == oldChar {
                        result.append(newChar)
                    } else {
                        result.append(char)
                    }
                }
                billAmountTextField.text = result
            }
        }
    }
    
}

