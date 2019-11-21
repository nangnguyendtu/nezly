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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel3: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonView.layer.cornerRadius = 10
        
        buyLabel.backgroundColor = UIColor(rgb: 0x8863D5)
        containerView.backgroundColor = UIColor(rgb: 0x8863D5)
    
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 6
    }
   
   
}
