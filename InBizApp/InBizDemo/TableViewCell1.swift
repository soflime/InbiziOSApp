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
    @IBOutlet weak var productOwnerType: UILabel!
    
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var productOwnerEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        productOwnerEmail.dataDetectorTypes = .link
        
    }

    @IBAction func linkBtnAction(_ sender: AnyObject) {
        
        let http = "https://"
        let urlStr = sender.titleLabel?.text ?? " "
       
        
        if let link = URL(string: http + urlStr) {
          UIApplication.shared.open(link)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
