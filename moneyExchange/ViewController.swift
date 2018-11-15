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
    
    @IBOutlet weak var txtResult: UILabel!
    
    @IBOutlet weak var btnConvert: UIButton!
    
    @IBOutlet weak var autoSwitch: UISwitch!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var imgFlag: UIImageView!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var txtFlag: UILabel!
    
    @IBOutlet weak var txtValFlag: UILabel!
        
    var from: Currency!
    
    var to: Currency!
    
    var currencies: [Currency] = Persistence.getCurrencies()
    
    var indexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        from = currencies[0]
        to = currencies[0]
        txtValFlag.text = String(currencies[0].euroValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        let amount: Double? = Double(fieldAmount.text!)
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
        if sender.text == "999" {
            performSegue(withIdentifier: "showHack", sender: self)
        }
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
    
}

