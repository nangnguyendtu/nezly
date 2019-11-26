//
//  UIFont.swift
//  Nezly
//
//  Created by Nguyen on 11/22/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func OpenSansBold (size s: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: s)!
    }
    class func OpenSansSemibold (size s: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Semibold", size: s)!
    }
    class func OpenSansRegular (size s: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans", size: s)!
    }
    class func OpenSansExtrabold (size s: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Extrabold", size: s)!
    }
}
