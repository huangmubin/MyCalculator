//
//  KeyButton.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class KeyButton: Button {
    
    var key: Int = 0
    var name: String {
        if key < Calculator.Infos.keys.count {
            return Calculator.Infos.keys[key]
        } else {
            return "Error: \(key)"
        }
    }
    
}
