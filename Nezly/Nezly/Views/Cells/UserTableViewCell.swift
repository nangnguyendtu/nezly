//
//  UserTableViewCell.swift
//  Nezly
//
//  Created by Nguyen on 10/28/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.font = UIFont.OpenSansSemibold(size: 17)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
