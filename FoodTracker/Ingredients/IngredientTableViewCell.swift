//
//  IngredientTableViewCell.swift
//  FoodTracker
//
//  Created by Tom Fraser on 07/03/2019.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
