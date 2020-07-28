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
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        if let boolean = UserDefaults.standard.string(forKey: "darkMode") {
            if boolean == "true" {
                enableDarkMode()
                darkModeSwitch.isOn = true
            } else {
                enableLightMode()
                darkModeSwitch.isOn = false
            }
        } else {
            enableLightMode()
            darkModeSwitch.isOn = false
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
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func switchToggled(_ sender: Any) {
        if darkModeSwitch.isOn {
            UserDefaults.standard.set("true", forKey: "darkMode")
            enableDarkMode()
        } else {
            UserDefaults.standard.set("false", forKey: "darkMode")
            enableLightMode()
        }
        UserDefaults.standard.synchronize()
    }
    
    func enableDarkMode() {
        view.backgroundColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1.00) //4A5B66
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.36, green: 0.44, blue: 0.48, alpha: 1.00) //5C707B
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func enableLightMode() {
        view.backgroundColor = UIColor(red: 0.74, green: 0.79, blue: 0.82, alpha: 1.00) //BDCAD2
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.84, green: 0.88, blue: 0.90, alpha: 1.00) //D7E0E5
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
    }
    

}
