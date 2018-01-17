//
//  CalculatorController.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class CalculatorController: ViewController, KeyboardDelegate {

    // MARK: - Model
    
    let calculator: Calculator = Calculator()
    
    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        display.current.text = "0"
        display.expression.text = ""
        update_keyboard_brackets()
    }
    
    // MARK: - Display
    
    @IBOutlet weak var display: BasisDisplay!
    
    func update_display() {
        display.current.text = calculator.current.string()
        display.expression.text = calculator.expression_text()
        display.deploy_frame()
    }
    
    // MARK: - Keyboard
    
    @IBOutlet weak var keyboard: BasisKeyboard!
    
    func update_keyboard_brackets() {
        keyboard.operates[")"]?.isEnabled = calculator.brackets > 0
        if calculator.expression.count == 0 {
            keyboard.operates["("]?.isEnabled = true
        } else {
            switch calculator.expression.last!.type {
            case .operate:
                keyboard.operates["("]?.isEnabled = true
            case .value:
                keyboard.operates["("]?.isEnabled = false
            }
        }
    }
    
    func keyboard_number(button: NumberButton) {
        if calculator.current.append(key: button.key) {
            update_display()
            update_keyboard_brackets()
        } else {
            display.current.text = Calculator.Error.beyond
            display.deploy_frame()
            keyboard.numbers(enable: false, unless: [])
            keyboard.operates(enable: false, unless: [])
            keyboard.actions(enable: false, unless: ["Reset"])
            keyboard.scroll_view.scrollRectToVisible(keyboard.scroll_view.bounds, animated: true)
        }
    }
    
    func keyboard_operate(button: OperateButton) {
        switch button.name {
        case ".":
            calculator.current.pointer = true
        default:
            calculator.input_end()
            calculator.input_operate(key: button.key)
        }
        update_display()
        update_keyboard_brackets()
    }
    
    func keyboard_action(button: ActionButton) {
        switch Calculator.Infos.keys[button.key] {
        case "=":
            break
        case "Reset":
            calculator.current.clear()
            calculator.expression.removeAll()
            keyboard.numbers(enable: true, unless: [])
            keyboard.operates(enable: true, unless: [])
            keyboard.actions(enable: true, unless: [])
        case "Clear":
            if calculator.current.is_clear() {
                if calculator.expression.count > 1 {
                    calculator.expression.removeLast()
                }
            } else {
                calculator.current.remove()
            }
        default: break
        }
        update_display()
    }
    
}
