//
//  BasisDisplay.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class BasisDisplay: Display {

    override func deploy_frame() {
        expression.frame = CGRect(
            x: 8, y: 8,
            width: bounds.width - 16,
            height: (bounds.height - 16) / 3
        )
        if let font = expression.text?.font(largest_font: UIFont.systemFont(ofSize: 50, weight: .thin), limit: expression.bounds) {
            expression.font = font
        }
        
        current.frame = CGRect(
            x: 8,
            y: expression.frame.maxY,
            width: expression.bounds.width,
            height: (bounds.height - 16) / 2 * 2
        )
        if let font = current.text?.font(largest_font: UIFont.systemFont(ofSize: 200, weight: .thin), limit: current.bounds, line: 1) {
            current.font = font
        }
    }
    
}
