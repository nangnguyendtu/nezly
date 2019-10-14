//
//  CollectionViewCell.swift
//  Nezly
//
//  Created by Nguyen on 10/8/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    nameButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }

}
