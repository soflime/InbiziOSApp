//
//  TableViewCell.swift
//  TabbedApp
//
//  Created by User on 28/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //@IBOutlet weak var lblTitle: UILabel!
   // @IBOutlet weak var ivPhoto: UIImageView!
    
    
    @IBOutlet weak var followCount: UILabel!
    @IBOutlet weak var lblProdName: UILabel!
    
    @IBOutlet weak var lblProdCategory: UILabel!
    
    @IBOutlet weak var lblProdSpecification: UILabel!
    
    @IBOutlet weak var lblProductPrice: UILabel!
    
    @IBOutlet weak var btnFollow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
