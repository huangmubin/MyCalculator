//
//  BasisKeyboard.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class BasisKeyboard: Keyboard {
    
    // MARK: - Init
    
    override func deploy_init() {
        super.deploy_init()
        for key in ["Clear", "Reset"] {
            if let button = actions[key] {
                scroll_view.addSubview(button)
            }
        }
        for key in ["(", ")"] {
            if let button = operates[key] {
                scroll_view.addSubview(button)
            }
        }
    }
    
    // MARK: - Frame
    
    override func deploy_frame() {
        let width = bounds.width / 4
        let height = bounds.height / 5
        
        // 1 - 9
        for i in 1 ..< 10 {
            numbers["\(i)"]?.frame = CGRect(
                x: CGFloat((i - 1) % 3) * width,
                y: CGFloat(3 - (i - 1) / 3) * height,
                width: width, height: height
            )
        }
        
        //
        for (i, key) in ["÷","×","+","-"].enumerated() {
            operates[key]?.frame = CGRect(
                x: 3 * width,
                y: CGFloat(i + 1) * height,
                width: width, height: height
            )
        }
        
        // 0 . =
        numbers["0"]?.frame = CGRect(
            x: 0,
            y: 4 * height,
            width: width, height: height
        )
        operates["."]?.frame = CGRect(
            x: width,
            y: 4 * height,
            width: width, height: height
        )
        actions["="]?.frame = CGRect(
            x: 2 * width,
            y: 4 * height,
            width: width, height: height
        )
        
        // Scroll View
        scroll_view.frame = CGRect(
            x: 0, y: 0,
            width: frame.width,
            height: height
        )
        
        actions["Reset"]?.frame = CGRect(
            x: 0, y: 0, width: width, height: height
        )
        for (i, key) in ["(", ")"].enumerated() {
            operates[key]?.frame = CGRect(
                x: CGFloat(i + 1) * width,
                y: 0,
                width: width, height: height
            )
        }
        actions["Clear"]?.frame = CGRect(
            x: 3 * width, y: 0, width: width, height: height
        )
        
        update_button_font(rect: CGRect(x: 0, y: 0, width: width / 2, height: height / 2))
    }
    
    
}
