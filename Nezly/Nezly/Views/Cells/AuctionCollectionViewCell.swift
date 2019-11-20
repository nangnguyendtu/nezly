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
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var nameLabel3: UILabel!
    @IBOutlet weak var nameLabel4: UILabel!
    @IBOutlet weak var nameLabel5: UILabel!
    @IBOutlet weak var nameLabel6: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var containerView: UIView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonView.layer.cornerRadius = 10
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        nameLabel2.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        nameLabel3.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        nameLabel4.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        nameLabel5.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        nameLabel6.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        nameButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        nameLabel4.backgroundColor = UIColor(rgb: 0x8863D5)
        containerView.backgroundColor = UIColor(rgb: 0x8863D5)
    
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 6
    }
   
   
}
