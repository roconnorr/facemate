//
//  ProductTableViewCell.swift
//  facemate
//
//  Created by Rory O'Connor on 17/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var repeatsLabel: UILabel!
    
    @IBOutlet weak var AMPMLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var categoriesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
