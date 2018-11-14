//
//  Persistence.swift
//  moneyExchange
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import UIKit

class Persistence {
    
    private static let CURRENCIES_KEY = "currencies"
    
    private static let storage = UserDefaults.standard
    
    private static let defaultCurrencies: [Currency] = [
        Currency(name: "Euro", code: "EUR", symbol: "€", img: UIImage(named: "euro")!,background: UIImage(named:"backeuro")!,euroValue: 1.00),
        Currency(name: "Dollar", code: "USD", symbol: "＄", img: UIImage(named: "dollar")!, background: UIImage(named:"backdollar")!,euroValue: 0.87676),
        Currency(name: "Yen", code: "JPY", symbol: "¥", img: UIImage(named: "yen")!, background: UIImage(named:"backyen")!,euroValue: 0.00784),
        Currency(name: "Pound", code: "GBP", symbol: "£", img: UIImage(named: "pound")!, background: UIImage(named:"backpound")!,euroValue: 1.12466),
        Currency(name: "Rupee", code: "INR", symbol: "₹", img: UIImage(named: "rupee")!,background: UIImage(named:"backrupee")!, euroValue: 0.01199),
        ]
    
    
    static func getCurrencies() -> [Currency] {
        let data:Data? = storage.object(forKey: CURRENCIES_KEY) as? Data
        if data == nil {
            return defaultCurrencies
        } else {
            return try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Currency.self,UIImage.self], from: data!) as! [Currency] 
        }

    }
    
    static func setCurrencies(currencies: inout [Currency]) {
        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: currencies as Array, requiringSecureCoding: false)
        storage.set(encodedData, forKey: CURRENCIES_KEY)
    }

    
}
