//
//  ViewController.swift
//  Tipper
//
//  Created by SB on 7/14/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipAmountSlider: UISlider!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var lastDefaultTip = "3" // Default tip starting at 18%, coming from picker values: 0 is 15, 1 is 16, ... 3 is 18 ...
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
        totalAmountLabel.textAlignment = .right
        
        // keyboard type & delegate
        billAmountTextField.keyboardType = .decimalPad
        billAmountTextField.delegate = self
        billAmountTextField.borderStyle = .none
        
        // perform loading here
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let boolean = UserDefaults.standard.string(forKey: "darkMode") {
            if boolean == "true" {
                enableDarkMode()
            } else {
                enableLightMode()
            }
        } else {
            enableLightMode()
        }
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
        totalAmountLabel.text = localCurrency! + numberFormatter.string(from: total as NSNumber)!
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
            
            let fractionalParts = billAmountTextField.text?.components(separatedBy: Locale.current.decimalSeparator!) ?? []
            
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
    
    func enableDarkMode() {
        view.backgroundColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1.00) //4A5B66
        tipAmountSlider.minimumTrackTintColor = UIColor(red: 0.89, green: 0.69, blue: 0.32, alpha: 1.00) //E4B052
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.36, green: 0.44, blue: 0.48, alpha: 1.00) //5C707B
        navigationController?.navigationBar.tintColor = UIColor.white
        
        billLabel.textColor = UIColor.white
        billAmountTextField.textColor = UIColor.white
        tipPercentageLabel.textColor = UIColor.white
        tipAmountLabel.textColor = UIColor.white
        totalLabel.textColor = UIColor.white
        totalAmountLabel.textColor = UIColor.white
        
    }
    
    func enableLightMode() {
        view.backgroundColor = UIColor(red: 0.74, green: 0.79, blue: 0.82, alpha: 1.00) //BDCAD2
        tipAmountSlider.minimumTrackTintColor = UIColor(red: 0.99, green: 0.97, blue: 0.72, alpha: 1.00) //FCF7B7
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.84, green: 0.88, blue: 0.90, alpha: 1.00) //D7E0E5
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
        
        billLabel.textColor = UIColor.black
        billAmountTextField.textColor = UIColor.black
        tipPercentageLabel.textColor = UIColor.black
        tipAmountLabel.textColor = UIColor.black
        totalLabel.textColor = UIColor.black
        totalAmountLabel.textColor = UIColor.black
    }
    
}

