//
//  AuctionCollectionViewCell.swift
//  Nezly
//
//  Created by Nguyen on 10/8/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class AuctionCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var buttonView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonView.layer.cornerRadius = 10
    }
   
}
