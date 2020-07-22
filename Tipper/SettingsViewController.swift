//
//  SettingsViewController.swift
//  Tipper
//
//  Created by SB on 7/21/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var tipPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Set the delegate and the date source of the tip picker to be this controller
        tipPicker.delegate = self
        tipPicker.dataSource = self
        
        // check for last saved tipPicker
        if let lastPicker = UserDefaults.standard.string(forKey: "tipPicker") {
            tipPicker.selectRow(Int(lastPicker)!, inComponent: 0, animated: false)
        } else {
            print("no preference yet")
            tipPicker.selectRow(3, inComponent: 0, animated: false)
        }
    }
    
    // MARK: - Picker view data source methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 86
    }
    
    // MARK: - Picker view delegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+15)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update UserDefaults to save default tip preference
        UserDefaults.standard.set(String(row), forKey: "tipPicker")
    }

}
