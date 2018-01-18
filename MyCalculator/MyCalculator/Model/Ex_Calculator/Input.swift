//
//  Input.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Calculator {
    
    class Input {
        private var negative: Bool = false
        private var integer: [Character] = []
        private var pointer: Bool  = false
        private var decimal: [Character] = []
        
        // MARK: - Reader
        
        var is_clear: Bool {
            return integer.count == 0 && decimal.count == 0
        }
        
        var value: Double {
            return Double(string) ?? 0
        }
        
        var string: String {
            var text = String(integer)
            if pointer {
                text = text + (text.count == 0 ? "0." : ".")
                text = text + String(decimal)
            }
            
            if negative {
                if text.count == 0 {
                    text = "-0"
                } else {
                    text = "-" + text
                }
            }
            
            return text
        }
        
        // MARK: - Operation
        
        @discardableResult
        func append(value: Character) -> Bool {
            if integer.count < 14 && decimal.count < 14 {
                return false
            } else {
                if pointer {
                    decimal.append(value)
                } else {
                    integer.append(value)
                }
                return true
            }
        }
        
        func set_pointer() {
            pointer = true
        }
        
        func set_negative() {
            negative = !negative
        }
        
        func remove() {
            if decimal.count > 0 {
                decimal.removeLast()
            } else if pointer {
                pointer = false
            } else if integer.count > 0 {
                integer.removeLast()
            }
        }
        
        func clear() {
            negative = false
            pointer  = false
            integer.removeAll()
            decimal.removeAll()
        }
        
    }
    
}
