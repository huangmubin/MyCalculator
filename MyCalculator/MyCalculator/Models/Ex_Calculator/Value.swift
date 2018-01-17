//
//  Value.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Calculator {
    
    class InputValue {
        var positive: Bool = true
        var integer: [Int] = []
        var pointer: Bool = false
        var decimal: [Int] = []
        
        /** Add number */
        func append(key: Int) -> Bool {
            if integer.count < 14 && decimal.count < 14 {
                if pointer {
                    decimal.append(key)
                } else {
                    integer.append(key)
                }
                return true
            } else {
                return false
            }
        }
        
        /** Remove the last number */
        func remove() {
            if decimal.count > 0 {
                decimal.removeLast()
            } else if pointer {
                pointer = false
            } else {
                integer.removeLast()
            }
        }
        
        /** Clear */
        func clear() {
            integer.removeAll()
            decimal.removeAll()
            pointer = false
        }
        
        /** Output the text */
        func string() -> String {
            if integer.count == 0 && decimal.count == 0 {
                return ""
            }
            
            var text = integer.count == 0 ? "0" : ""
            for i in integer {
                text.append("\(i)")
            }
            if pointer {
                text.append(".")
                for d in decimal {
                    text.append("\(d)")
                }
            }
            
            if text != "0" && !positive {
                text = "-" + text
            }
            return text
        }
        
        /** Output the number */
        func value() -> Double {
            return Double(string()) ?? 0
        }
        
        /** is a clear input */
        func is_clear() -> Bool {
            return integer.count == 0 && decimal.count == 0
        }
        
    }
}
