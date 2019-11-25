//
//  DetailViewController.swift
//  TabbedApp
//
//  Created by User on 28/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
//    let CellId = "Cell"
    

    @IBOutlet weak var txtProductName: UILabel!
    @IBOutlet weak var txtProductCategory: UILabel!
    @IBOutlet weak var txtViewProductSpecification: UITextView!
    
    @IBOutlet weak var productSpacificationLbl: UILabel!
    var strImageName: String!
    var productName: String!
    var productCategory: String!
    var productSpecification: String!
    var productDescription: String!
    var productPrice: String!
    
    @IBOutlet weak var iDisplayImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtProductName.text = "Product Name:  \(productName ?? "")"
//        txtProductCategory.text = "Product Category:  \(productCategory ?? "")"
//        txtViewProductSpecification.text = "\(productSpecification ?? "")"
 //       txtViewProductSpecification.text = "\(productSpecification ?? "")"

        txtProductName.text = productName ?? ""
        txtProductCategory.text = productCategory ?? ""
//        txtViewProductSpecification.text = "\(productSpecification ?? "")"
        productSpacificationLbl.text = productSpecification ?? ""

//        productDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellId)
        
        // Register cell
//        productDetailsTableView.register(UINib.init(nibName: CellId, bundle: nil), forCellReuseIdentifier: CellId)
//        productDetailsTableView.rowHeight = UITableView.automaticDimension
//        productDetailsTableView.separatorColor = UIColor.clear
        
//        productDetailsTableView.delegate = self
//        productDetailsTableView.dataSource = self

    }
   
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell1
//            return cell
//        }
//        else if indexPath.row == 1{
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell1
//            return cell
//        }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell1
            cell.productNameLbl.text = productName ?? ""
            cell.productCategoryLbl.text = productCategory ?? ""
            cell.productSummaryLbl.text = productSpecification ?? ""
            return cell
        case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TableViewCell2
                cell.productDescriptionLbl.text = productDescription ?? " "
                return cell
        case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! TableViewCell3
                    return cell
        default:
            return UITableViewCell()
        }
        
        
       // cell.placeHolderLbl!.text = "asas"
//        cell.placeHolderLbl.text = "placcc"
//        cell.valueLbl.text = "This is sample value"
        


    }


}
