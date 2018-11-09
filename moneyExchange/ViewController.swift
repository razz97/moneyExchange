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
    
    @IBOutlet weak var btnConvert: UIButton!
    
    @IBOutlet weak var autoSwitch: UISwitch!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var imgFlag: UIImageView!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var txtFlag: UILabel!
    
    @IBOutlet weak var txtValFlag: UILabel!
    
    @IBOutlet weak var btnHack: UIButton!
    
    
    var from: Currency = Currency(name: "Euro", code: "EUR", symbol: "€", img: UIImage(named: "euro")!, background: UIImage(named:"backeuro")!,euroValue: 1.00)
    
    var to: Currency = Currency(name: "Euro", code: "EUR", symbol: "€", img: UIImage(named: "euro")!, background: UIImage(named: "backeuro")!,euroValue: 1.00)
    
    var currencies: [Currency] = [
        Currency(name: "Euro", code: "EUR", symbol: "€", img: UIImage(named: "euro")!,background: UIImage(named:"backeuro")!,euroValue: 1.00),
        Currency(name: "Dollar", code: "USD", symbol: "＄", img: UIImage(named: "dollar")!, background: UIImage(named:"backdollar")!,euroValue: 0.87676),
        Currency(name: "Yen", code: "JPY", symbol: "¥", img: UIImage(named: "yen")!, background: UIImage(named:"backyen")!,euroValue: 0.00784),
        Currency(name: "Pound", code: "GBP", symbol: "£", img: UIImage(named: "pound")!, background: UIImage(named:"backpound")!,euroValue: 1.12466),
        Currency(name: "Rupee", code: "INR", symbol: "₹", img: UIImage(named: "rupee")!,background: UIImage(named:"backrupee")!, euroValue: 0.01199),
    ]
    
    var indexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        fieldAmount.delegate = self
       self.addDoneButtonOnKeyboard()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fieldAmount.resignFirstResponder()
        return true
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
        if autoSwitch.isOn {
            applyConversion()
        }
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
        if autoSwitch.isOn {
            applyConversion()
        }
        btnHack.isHidden = sender.text != "999"
    }
    
    @IBAction func autoSwitchChanged(_ sender: UISwitch) {
        btnConvert.isHidden = sender.isOn
    }
    
    @IBAction func convertTapped(_ sender: UIButton) {
        applyConversion()
    }
    @IBAction func nextTapped(_ sender: UIButton) {
        indexSelected = currencies.count == indexSelected + 1 ? 0 : indexSelected + 1
        changeFlag()

    }
    @IBAction func prevTapped(_ sender: UIButton) {
        indexSelected = indexSelected == 0 ? currencies.count - 1 : indexSelected - 1
        changeFlag()
    }
    
    func changeFlag() {
        let currency:Currency = currencies[indexSelected]
        imgFlag.image = currency.img
        txtFlag.text = currency.name
        txtValFlag.text = "\(currency.euroValue) €"
        imgBackground.image = currency.background
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.fieldAmount.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
        self.fieldAmount.resignFirstResponder()
    }
}

