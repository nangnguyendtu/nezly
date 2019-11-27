//
//  UIColor.swift
//  Nezly
//
//  Created by Nguyen on 10/28/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//
import UIKit

extension UIColor {
    
    convenience init(hex: Int, alpha: Double = 1.0) {
        
        self.init(red: CGFloat((hex>>16)&0xFF)/255.0, green:CGFloat((hex>>8)&0xFF)/255.0, blue: CGFloat((hex)&0xFF)/255.0, alpha:  CGFloat(255 * alpha) / 255)
    }
}
