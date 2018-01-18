//
//  Unit.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Calculator {
    
    /** Calculator Unit */
    class Unit {
        
        let type: Calculator.Types
        let value: Double
        let name: String
        
        init(value: Double) {
            self.type  = .value
            self.value = value
            self.name  = value.is_only_integer ? Int(value).description : value.description
        }
        
        init(name: String) {
            self.type  = .operate
            self.value = 100
            self.name  = name
        }
        
        init(bracket: Bool) {
            self.type  = .bracket
            self.value = bracket ? 1 : -1
            self.name  = bracket ? "(" : ")"
        }
        
    }
    
}
