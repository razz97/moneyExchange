//
//  HackViewController.swift
//  moneyExchange
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class HackViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var currencies: [Currency] = Persistence.getCurrencies()
    var pos: Int = 0
    
    
    @IBOutlet weak var txtFeedback: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var fieldValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldValue.text = String(currencies[0].euroValue)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        return currencies[row].name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int) {
        pos = didSelectRow
        fieldValue.text = String(currencies[pos].euroValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        
    
    @IBAction func apply(_ sender: UIButton) {
        if fieldValue.text != nil {
            currencies[pos].euroValue = Double(fieldValue.text!) ?? 0
            Persistence.setCurrencies(currencies: &currencies)
            txtFeedback.text = "The new value for \(currencies[pos].name) is \(currencies[pos].euroValue) euros."
        }
        
    }
    

}
