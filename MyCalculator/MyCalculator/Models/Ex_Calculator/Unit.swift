//
//  Unit.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Calculator {
    class Unit {
        let type: Calculator.UnitType
        var value: Double = 0
        var key: Int = 0
        
        init(value: Double) {
            self.type = Calculator.UnitType.value
            self.value = value
        }
        
        init(key: Int) {
            self.type = Calculator.UnitType.operate
            self.key = key
        }
        
        func string() -> String {
            switch type {
            case .value:
                if value - Double(Int(value)) > 0 {
                    return value.description
                } else {
                    return Int(value).description
                }
            case .operate:
                return Calculator.Infos.keys[key]
            }
        }
    }
}
