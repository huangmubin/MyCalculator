//
//  Display.swift
//  MyCalculator
//
//  Created by Myron on 2018/1/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class Display: UIView {

    let current: UILabel = UILabel()
    let expression: UILabel = UILabel()
    
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
        expression.textAlignment = .right
        expression.text = "0"
        expression.textColor = UIColor(160, 160, 160)
        expression.numberOfLines = 0
        addSubview(expression)
        
        current.textAlignment = .right
        current.text = "0"
        current.textColor = UIColor(30, 30, 30)
        addSubview(current)
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

}
