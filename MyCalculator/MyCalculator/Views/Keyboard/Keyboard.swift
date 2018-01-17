//
//  Keyboard.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: NSObjectProtocol {
    func keyboard_number(button: NumberButton)
    func keyboard_operate(button: OperateButton)
    func keyboard_action(button: ActionButton)
}

class Keyboard: UIView, UIScrollViewDelegate {

    weak var delegate: KeyboardDelegate?
    @IBOutlet weak var delegate_object: NSObject? = nil {
        didSet {
            if let object = delegate_object as? KeyboardDelegate {
                delegate = object
            }
        }
    }

    
    var numbers: [String: NumberButton] = [:]
    var operates: [String: OperateButton] = [:]
    var actions: [String: ActionButton] = [:]
    
    // MARK: - Init
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        deploy_init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deploy_init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy_init()
    }
    
    func deploy_init() {
        numbers.removeAll(keepingCapacity: true)
        for i in 0 ..< 10 {
            append_number_button(key: i)
        }
        
        operates.removeAll(keepingCapacity: true)
        for i in 20 ..< 27 {
            append_operate_button(key: i)
        }
        
        actions.removeAll(keepingCapacity: true)
        for i in 40 ..< 43 {
            append_action_button(key: i)
        }
        
        // Scroll View
        addSubview(scroll_view)
        scroll_view.isPagingEnabled = true
        scroll_view.showsVerticalScrollIndicator = false
        scroll_view.showsHorizontalScrollIndicator = false
        scroll_view.delegate = self
        
        // Offset
        addSubview(offset.left)
        addSubview(offset.right)
        offset.left.setTitle(">>", for: .normal)
        offset.right.setTitle("<<", for: .normal)
    }
    
    // MARK: - Frame
    
    override var frame: CGRect {
        didSet {
            if frame.width != oldValue.width || frame.height != oldValue.height {
                deploy_frame()
            }
        }
    }
    
    override var bounds: CGRect {
        didSet {
            if bounds.width != oldValue.width || bounds.height != oldValue.height {
                deploy_frame()
            }
        }
    }
    
    func deploy_frame() { }
    
    func update_button_font(rect: CGRect) {
        let font = "0".font(largest_font: UIFont.systemFont(ofSize: 30, weight: .thin), limit: rect)
        
        for (_, button) in numbers {
            button.titleLabel?.font = font
        }
        for (_, button) in operates {
            button.titleLabel?.font = font
        }
        for (_, button) in actions {
            button.titleLabel?.font = font
        }
    }
    
    // MARK: - Buttons
    
    func append_number_button(key: Int) {
        let number = NumberButton()
        number.key = key
        number.setTitle(number.name, for: .normal)
        number.normal_color = UIColor(30,30,30)
        number.invalid_color = UIColor(220, 220, 220)
        number.background_color = UIColor.white
        number.addTarget(self, action: #selector(keyboard_number_action(_:)), for: .touchUpInside)
        addSubview(number)
        numbers[number.name] = number
    }
    func append_operate_button(key: Int) {
        let operate = OperateButton()
        operate.key = key
        operate.setTitle(operate.name, for: .normal)
        operate.normal_color = UIColor(245,166,35)
        operate.invalid_color = UIColor(220, 220, 220)
        operate.background_color = UIColor.white
        operate.addTarget(self, action: #selector(keyboard_operate_action(_:)), for: .touchUpInside)
        addSubview(operate)
        operates[operate.name] = operate
    }
    func append_action_button(key: Int) {
        let action = ActionButton()
        action.key = key
        action.setTitle(action.name, for: .normal)
        action.normal_color = UIColor(255,86,107)
        action.invalid_color = UIColor(220, 220, 220)
        action.background_color = UIColor.white
        action.addTarget(self, action: #selector(keyboard_action_action(_:)), for: .touchUpInside)
        addSubview(action)
        actions[action.name] = action
    }
    
    @objc func keyboard_number_action(_ sender: NumberButton) {
        print("keyboard_number_action \(sender.name)")
        delegate?.keyboard_number(button: sender)
    }
    @objc func keyboard_operate_action(_ sender: OperateButton) {
        print("keyboard_operate_action \(sender.name)")
        delegate?.keyboard_operate(button: sender)
    }
    @objc func keyboard_action_action(_ sender: ActionButton) {
        print("keyboard_action_action \(sender.name)")
        delegate?.keyboard_action(button: sender)
    }
    
    // MARK: - Button Status
    
    func numbers(enable: Bool, unless: [String]) {
        for (name, button) in numbers {
            if !unless.contains(name) {
                button.isEnabled = enable
            }
        }
    }
    
    func operates(enable: Bool, unless: [String]) {
        for (name, button) in operates {
            if !unless.contains(name) {
                button.isEnabled = enable
            }
        }
    }
    
    func actions(enable: Bool, unless: [String]) {
        for (name, button) in actions {
            if !unless.contains(name) {
                button.isEnabled = enable
            }
        }
    }
    
    // MARK: - Scroll View
    
    let scroll_view: UIScrollView = UIScrollView()
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        offset.left.isHidden = (scrollView.contentOffset.x == 0)
        offset.right.isHidden = (scrollView.contentOffset.x + scrollView.bounds.width == scrollView.contentSize.width)
    }
    
    // MARK: - Offset Button
    
    class Offset {
        let left: UIButton = UIButton()
        let right: UIButton = UIButton()
    }
    
    let offset = Offset()
    
    
}
