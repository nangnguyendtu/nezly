//
//  ListCollectionViewCell.swift
//  Nezly
//
//  Created by Nguyen on 10/8/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        nameLabel.font = UIFont(name:"Avenir-Book",size:14)
    }

}
