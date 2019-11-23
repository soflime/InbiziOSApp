//
//  DetailViewTableViewCell.swift
//  InBizDemo
//
//  Created by Virendra Gupta on 23/11/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class DetailViewTableViewCell: UITableViewCell {

    @IBOutlet weak var placeHolderLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
