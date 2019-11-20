//
//  ListCollectionViewCell.swift
//  Nezly
//
//  Created by Nguyen on 10/8/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

protocol DataCollectionProtocol {
    func removeCell(indx: Int)
}

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate: DataCollectionProtocol?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        nameLabel.font = UIFont(name:"Avenir-Book",size: 14)
    }
   
    @IBAction func removeCell(_ sender: Any) {
        delegate?.removeCell(indx: (index?.row)!)
    }
}
