//
//  ViewController.swift
//  moneyExchange
//
//  Created by Alex on 29/10/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var fieldAmount: UITextField!
    
    @IBOutlet weak var txtResult: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var from: Currency = Currency.init(name: "Euro", code: "EUR", symbol: "€", imgSource: "", euroValue: 1.00)
    var to: Currency = Currency.init(name: "Euro", code: "EUR", symbol: "€", imgSource: "", euroValue: 1.00)
    
    var currencies: [Currency] = [
        Currency(name: "Euro", code: "EUR", symbol: "€", imgSource: "", euroValue: 1.00),
        Currency(name: "Dollar", code: "USD", symbol: "＄", imgSource: "", euroValue: 0.87676),
        Currency(name: "Yen", code: "JPY", symbol: "¥", imgSource: "", euroValue: 0.00784),
        Currency(name: "Pound", code: "GBP", symbol: "£", imgSource: "", euroValue: 1.12466),
        Currency(name: "Rupee", code: "INR", symbol: "₹", imgSource: "", euroValue: 0.01199),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        fieldAmount.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text != "" || string != "" {
            let res = (textField.text ?? "") + string
            return Double(res) != nil
        }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        return currencies[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int) {
        if inComponent == 0 {
            from = currencies[didSelectRow]
        } else {
            to = currencies[didSelectRow]
        }
        applyConversion()
    }
    
    func applyConversion() {
        let amount = Double(fieldAmount.text!)
        
        if amount != nil && from != to {
            let val = amount! * from.getRate(other: to)
            txtResult.text = String(format: "%.4f", val)
        } else if fieldAmount.text != nil {
            txtResult.text = fieldAmount.text
        }
    }
    
    @IBAction func amntChanged(_ sender: UITextField) {
        applyConversion()
    }
    
}

