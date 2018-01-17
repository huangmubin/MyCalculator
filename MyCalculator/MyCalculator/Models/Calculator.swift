//
//  Calculator.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class Calculator {

    var expression: [Calculator.Unit] = []
    var current: Calculator.InputValue = Calculator.InputValue()
    var result: Double = 0
    
    // MARK: - Brackets
    
    var brackets: Int = 0
    
    
    // MARK: - Action
    
    /** Output the expression text */
    func expression_text() -> String {
        var text = ""
        for (i, unit) in expression.enumerated() {
            text = text + unit.string() + ((i == expression.count - 1) ? "" : " ")
        }
        return text
    }
    
    /** Input end */
    func input_end() {
        if !current.is_clear() {
            expression.append(Calculator.Unit(value: current.value()))
            current.clear()
        }
    }
    
    /** Input a operate */
    func input_operate(key: Int) {
        switch key {
        case 25: // (
            brackets += 1
            expression.append(Calculator.Unit(key: key))
        case 26: // )
            brackets -= 1
            expression.append(Calculator.Unit(key: key))
        case 20 ..< 33: // ...
            if let unit = expression.last {
                switch unit.type {
                case .operate:
                    switch unit.key {
                    case 26:
                        expression.append(Calculator.Unit(key: key))
                    case 25:
                        brackets -= 1
                        expression[expression.count - 1] = Calculator.Unit(key: key)
                    default:
                        expression[expression.count - 1] = Calculator.Unit(key: key)
                    }
                case .value:
                    expression.append(Calculator.Unit(key: key))
                }
            }
        default: break
        }
        count_result()
    }
    
    /** Count result */
    func count_result() {
        
    }
    
    
    
    
}
