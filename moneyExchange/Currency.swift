//
//  Currency.swift
//  moneyExchange
//
//  Created by Alex on 29/10/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import UIKit

class Currency: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool = true
    var name: String
    var code: String
    var symbol: String
    var img: UIImage = UIImage()
    var background: UIImage = UIImage()
    var euroValue: Double
    
    init(name:String, code:String, symbol:String, img:UIImage, background:UIImage, euroValue:Double) {
        self.name = name
        self.code = code
        self.symbol = symbol
        self.img = img
        self.background = background
        self.euroValue = euroValue
    }
    
    // How much is 1 unit of self compared to the other currency
    func getRate(other:Currency) -> Double {
        return euroValue / other.euroValue
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(symbol, forKey: "symbol")
        aCoder.encode(img, forKey: "img")
        aCoder.encode(background, forKey: "background")
        aCoder.encode(euroValue, forKey: "euroValue")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.code = aDecoder.decodeObject(forKey: "code") as? String ?? ""
        self.symbol = aDecoder.decodeObject(forKey: "symbol") as? String ?? ""
        self.img = aDecoder.decodeObject(forKey: "img") as? UIImage ?? UIImage()
        self.background = aDecoder.decodeObject(forKey: "background") as? UIImage ?? UIImage()
        self.euroValue = aDecoder.decodeDouble(forKey: "euroValue")
    }
}


