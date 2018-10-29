//
//  ViewController.swift
//  moneyExchange
//
//  Created by Alex on 29/10/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet weak var fieldAmount: UITextField!
    
    @IBOutlet weak var txtConversion: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var from: Currency = Currency.init(name: "Euro", code: "EUR", symbol: "€", imgSource: "", euroValue: 1.00)
    var to: Currency = Currency.init(name: "Euro", code: "EUR", symbol: "€", imgSource: "", euroValue: 1.00)
    
    var currencies: [Currency] = [
        Currency.init(name: "Euro", code: "EUR", symbol: "€", imgSource: "", euroValue: 1.00),
        Currency.init(name: "Dollar", code: "USD", symbol: "＄", imgSource: "", euroValue: 0.87676),
        Currency.init(name: "Yen", code: "JPY", symbol: "¥", imgSource: "", euroValue: 0.00784),
        Currency.init(name: "Pound", code: "GBP", symbol: "£", imgSource: "", euroValue: 1.12466),
        Currency.init(name: "Rupee", code: "INR", symbol: "₹", imgSource: "", euroValue: 0.01199),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
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
        
        if from == to {
            txtConversion.text = fieldAmount.text
        } else {
            let val = Double(fieldAmount.text!)! * from.getRate(other: to)
            txtConversion.text = String(format: "%.4f", val)
        }
        
    }
    
}

