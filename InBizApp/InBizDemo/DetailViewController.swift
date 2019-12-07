//
//  DetailViewController.swift
//  TabbedApp
//
//  Created by User on 28/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
//    let CellId = "Cell"
    
    @IBOutlet weak var productDetailTbl: UITableView!
    
    @IBOutlet weak var txtProductName: UILabel!
    @IBOutlet weak var txtProductCategory: UILabel!
    @IBOutlet weak var txtViewProductSpecification: UITextView!
    
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var productSpacificationLbl: UILabel!
    var strImageName: String!
    var productName: String!
    var productId: Int!
    var productCategory: String!
    var productSpecification: String!
    var productDescription: String!
    var productPrice: String!
    var productOwnerType: String!
    var productOwnerEmail: String!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var commentListAarry = [[String:Any]]()
    
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
        
       // fetching all comments
        getComments()
        
        self.postBtn.layer.cornerRadius = 15
        
    

    }
   
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func showSpiner() -> Void {
           self.activityIndicator.startAnimating()
    
       }
       
       func hideSpiner() -> Void {
           self.activityIndicator.stopAnimating()
       }

    func getComments() {
        showSpiner()
        // fetch and change the state of data
        let dispatchQueue = DispatchQueue.init(label: "myQueue", qos: .background)
        dispatchQueue.async {
            Alamofire.request("http://tst5.jvmhost.net/Inbiz/comments/\(self.productId ?? 1)", method: .get, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    if let data = response.result.value as? [[String:Any]]{
                       self.hideSpiner()
                        
                        self.commentListAarry = data
                        self.productDetailTbl?.reloadData()
   
                    }
            }
            
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CommentViewController
        {
            let vc = segue.destination as? CommentViewController
            vc?.productId = self.productId
        }
    }
    
}




extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return self.commentListAarry.count
        }
        else{
            return 1
        }

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
            cell.productOwnerType.text = productOwnerType ?? ""
            cell.productOwnerEmail.text = productOwnerEmail ?? ""
            return cell
        case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TableViewCell2
                cell.productDescriptionLbl.text = productDescription ?? " "
                return cell
        case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! TableViewCell3
                    cell.commentLbl.text = self.commentListAarry[indexPath.row]["comment"] as? String
                    if indexPath.row == 0{
                        cell.titleLbl.text = "Post Comments"
                    }
                    else{
                        cell.titleLbl.isHidden = true
                    }
                    return cell
        default:
            return UITableViewCell()
        }
        
        
       // cell.placeHolderLbl!.text = "asas"
//        cell.placeHolderLbl.text = "placcc"
//        cell.valueLbl.text = "This is sample value"
        


    }
    



}
