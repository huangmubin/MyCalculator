//
//  Keyboard.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: NSObjectProtocol {
    func keyboard_number(button: NumberKey)
    func keyboard_operate(button: OperateKey)
    func keyboard_action(button: ActionKey)
}

class Keyboard: UIView {

    // MARK: - Delegate
    
    weak var delegate: KeyboardDelegate?
    
    // MAKR: - Keys
    
    var keys: [String: Key] = [:]
    var numbers: [String] {
        return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    }
    var operates: [String] {
        return ["+", "-", "×", "÷", "."]
    }
    var actions: [String] {
        return ["=", "(", ")", "-/+", "Clear","Reset"]
    }
    
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
        keys.removeAll(keepingCapacity: true)
        for name in numbers {
            button_append_number(name: name)
        }
        for name in operates {
            button_append_operate(name: name)
        }
        for name in actions {
            button_append_action(name: name)
        }
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
    
    func deploy_frame_buttons(rect: CGRect) {
        let font = "0".font(
            largest_font: UIFont.systemFont(ofSize: 30, weight: .thin),
            limit: rect
        )
        
        for (_, button) in keys {
            button.titleLabel?.font = font
        }
    }
    
    // MARK: - Buttons
    
    func button_append_number(name: String) {
        let key = NumberKey()
        key.name = name
        if let image = UIImage(named: name) {
            key.setImage(image, for: .normal)
        } else {
            key.setTitle(name, for: .normal)
        }
        key.setTitleColor(UIColor(30,30,30), for: .normal)
        key.setTitleColor(UIColor(220,220,220), for: .disabled)
        key.backgroundColor = UIColor(255,255,255)
        key.addTarget(self, action: #selector(keyboard_number_action(_:)), for: .touchUpInside)
        addSubview(key)
        keys[name] = key
    }
    
    func button_append_operate(name: String) {
        let key = OperateKey()
        key.name = name
        if let image = UIImage(named: name) {
            key.setImage(image, for: .normal)
        } else {
            key.setTitle(name, for: .normal)
        }
        key.setTitleColor(UIColor(245,166,35), for: .normal)
        key.setTitleColor(UIColor(220,220,220), for: .disabled)
        key.backgroundColor = UIColor(255,255,255)
        key.addTarget(self, action: #selector(keyboard_operate_action(_:)), for: .touchUpInside)
        addSubview(key)
        keys[name] = key
    }
    
    func button_append_action(name: String) {
        let key = ActionKey()
        key.name = name
        if let image = UIImage(named: name) {
            key.setImage(image, for: .normal)
        } else {
            key.setTitle(name, for: .normal)
        }
        key.setTitleColor(UIColor(255,86,107), for: .normal)
        key.setTitleColor(UIColor(220,220,220), for: .disabled)
        key.backgroundColor = UIColor(255,255,255)
        key.addTarget(self, action: #selector(keyboard_action_action(_:)), for: .touchUpInside)
        addSubview(key)
        keys[name] = key
    }
    
    @objc func keyboard_number_action(_ sender: NumberKey) {
        print("keyboard_number_action \(sender.name)")
        delegate?.keyboard_number(button: sender)
    }
    @objc func keyboard_operate_action(_ sender: OperateKey) {
        print("keyboard_operate_action \(sender.name)")
        delegate?.keyboard_operate(button: sender)
    }
       @objc func keyboard_action_action(_ sender: ActionKey) {
        print("keyboard_action_action \(sender.name)")
        delegate?.keyboard_action(button: sender)
    }
    
    /** Update buttons enable */
    func button_update(enable: Bool, names: [String]) {
        for name in names {
            keys[name]?.isEnabled = enable
        }
    }
    
    // MARK: - Scroll View
    
    var scroll: UIScrollView = UIScrollView()
    var scroll_left: UIButton = UIButton()
    var scroll_right: UIButton = UIButton()
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scroll_left.isHidden = (scrollView.contentOffset.x == 0)
        scroll_right.isHidden = (scrollView.contentOffset.x + scrollView.bounds.width == scrollView.contentSize.width)
    }
    
    
}
