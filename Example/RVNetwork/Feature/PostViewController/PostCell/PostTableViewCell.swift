//
//  PostTableViewCell.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 22/01/23.
//  Copyright © 2022 r.ranjanchn@gmail.com. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
