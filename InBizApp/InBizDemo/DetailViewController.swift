//
//  DetailViewController.swift
//  TabbedApp
//
//  Created by User on 28/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var txtProductName: UILabel!
    @IBOutlet weak var txtProductCategory: UILabel!
    @IBOutlet weak var txtViewProductSpecification: UITextView!
    
    var strImageName: String!
    var productName: String!
    var productCategory: String!
    var productSpecification: String!
    var productPrice: String!
    
    @IBOutlet weak var iDisplayImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtProductName.text = "Product Name:  \(productName ?? "")"
        txtProductCategory.text = "Product Category:  \(productCategory ?? "")"
        txtViewProductSpecification.text = "\(productSpecification ?? "")"

        // Do any additional setup after loading the view.
    }
   
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
