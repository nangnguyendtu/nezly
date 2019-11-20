//
//  UITableView.swift
//  Nezly
//
//  Created by Nguyen on 10/28/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func getCellFromNib(identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
