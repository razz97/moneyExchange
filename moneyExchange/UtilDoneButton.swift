//
//  UtilDoneButton.swift
//  moneyExchange
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import UIKit

protocol UtilDoneButton {
    
    func addDoneButtonOnKeyboard(fieldAmount: UITextField)
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
        
        fieldAmount.inputAccessoryView = doneToolbar
        
    }
    

    
    
}
