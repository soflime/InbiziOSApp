//
//  TableViewCell1.swift
//  InBizDemo
//
//  Created by Virendra Gupta on 25/11/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class TableViewCell1: UITableViewCell {

    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var productSummaryLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
