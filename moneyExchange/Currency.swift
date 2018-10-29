//
//  Currency.swift
//  moneyExchange
//
//  Created by Alex on 29/10/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

class Currency: Equatable {

    var name: String!
    var code: String!
    var symbol: String!
    var imgSource: String!
    var euroValue: Double!
    
    init(name:String, code:String, symbol:String, imgSource:String, euroValue:Double) {
        self.name = name
        self.code = code
        self.symbol = symbol
        self.imgSource = imgSource
        self.euroValue = euroValue
    }
    
    // How much is 1 of self compared to the other currency
    func getRate(other:Currency) -> Double {
        return other.euroValue / euroValue
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code
    }
}
