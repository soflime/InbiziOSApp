//
//  PostFormViewController.swift
//  InBizDemo
//
//  Created by sudhakar on 31/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class PostFormViewController: UIViewController, HTTRsponseDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductCategory: UITextField!
    @IBOutlet weak var txtProductSpecification: UITextField!
    @IBOutlet weak var txtProductPrice: UITextField!
    
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var txtProductSummary: UITextField!
    var productName: String!
    var productCategory: String!
    var productSpecification: String!
    var productPrice: String!
    var productDesription: String!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let client = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnPost.layer.cornerRadius = 15
        self.btnCancel.layer.cornerRadius = 15
        addSpiner()
        client.delegate = self
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPost(_ sender: Any) {
        
        productName = txtProductName.text
        productPrice = txtProductPrice.text
        productCategory = txtProductCategory.text
        productSpecification = txtProductSpecification.text
        productDesription = txtProductSummary.text
      // text field need to be added
        //  productDescription =
        
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        let parameter = ["productName":productName, "productCompanyName":"NA", "productPrice":productPrice,"userName":username, "productCategory":productCategory, "productDescription":productSpecification,"productDimension":productDesription]
        
        showSpiner()
        client.MakeRequest(parameters: parameter as [String : Any], url: "http://tst5.jvmhost.net/Inbiz/postProduct",method: .post)
    }
    
    func showNetworkError() {
        hideSpiner()
        self.view.makeToast("Please check your network connectivity")
    }
    
    func sendResponseData(data:NSDictionary) {
        
        hideSpiner()
        
        guard let code = data["statusCode"] as? NSInteger else {
            self.view.makeToast(data["response"] as? String)
            return
        }
        
        if (code == 200) {
            print("Post Successful!")
            UserDefaults.standard.set(true,forKey: "postSuccessful")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func addSpiner() -> Void {
        activityIndicator.frame = CGRect(x: (view.frame.size.width - 60)/2 , y: (view.frame.size.height - 60) / 2, width: 60, height: 60)
        activityIndicator.backgroundColor = UIColor.clear
        activityIndicator.center = view.center
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .black
        self.view.addSubview(activityIndicator)
    }
    
    
    func showSpiner() -> Void {
        self.activityIndicator.startAnimating()
    }
    
    func hideSpiner() -> Void {
        self.activityIndicator.stopAnimating()
    }
}
