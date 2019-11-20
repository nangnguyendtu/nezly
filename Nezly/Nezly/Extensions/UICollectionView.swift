//
//  UICollectionView.swift
//  Nezly
//
//  Created by Nguyen on 10/10/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

extension UICollectionView {
    func getCellFromNib(identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
