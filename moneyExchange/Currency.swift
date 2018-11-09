//
//  Currency.swift
//  moneyExchange
//
//  Created by Alex on 29/10/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import UIKit

class Currency: Equatable {

    var name: String
    var code: String
    var symbol: String
    var img: UIImage = UIImage()
    var background: UIImage = UIImage()
    var euroValue: Double
    var hackedValue: Double
    
    init(name:String, code:String, symbol:String, img:UIImage, background:UIImage, euroValue:Double) {
        self.name = name
        self.code = code
        self.symbol = symbol
        self.img = img
        self.background = background
        self.euroValue = euroValue
        self.hackedValue = euroValue
    }
    
    // How much is 1 unit of self compared to the other currency
    func getRate(other:Currency) -> Double {
        return euroValue / other.euroValue
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code
    }
}
