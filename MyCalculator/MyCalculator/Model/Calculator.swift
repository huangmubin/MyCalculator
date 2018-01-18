//
//  Calculator.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class Calculator {
    
    /** */
    var expression: [Calculator.Unit] = []
    /** Input */
    var input: Calculator.Input = Calculator.Input()
    
    // MARK: - Status
    
    var can_bracket_left: Bool {
        if expression.count == 0 {
            return true
        } else if expression.last!.type == .operate {
            return true
        } else {
            return false
        }
    }
    
    var can_bracket_right: Bool {
        var v = 0
        for unit in expression {
            if unit.type == .bracket {
                v += Int(unit.value)
            }
        }
        return v == 1
    }
    
    var can_operate: Bool {
        return expression.count > 0 && expression.last!.type != .bracket && !input.is_clear
    }
    
    // MARK: - Actions
    
    func append(value: Character) -> Bool {
        return input.append(value: value)
    }
    
    func append(operate: String) {
        expression.append(Calculator.Unit(value: input.value))
        expression.append(Calculator.Unit(name: operate))
        input.clear()
    }
    
    // MARK: - Count
    
    func run() {
        
    }
    
}
