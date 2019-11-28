//
//  PostFormViewController.swift
//  InBizDemo
//
//  Created by sudhakar on 31/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

let errorMsg = "All fields are mandatory. kindly fill missing data !"

class PostFormViewController: UIViewController, HTTRsponseDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductCategory: UITextField!
    @IBOutlet weak var txtProductSpecification: UITextField!
    @IBOutlet weak var txtProductPrice: UITextField!
     @IBOutlet weak var txtProductSummary: UITextField!
    
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
   
    var productName: String!
    var productCategory: String!
    var productSpecification: String!
    var productPrice: String!
    var productDesription: String!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let client = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding picker view to the textfield
        createPickerView()
        dismissPickerView()
        
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
   
        //text field validation
        if (txtProductName.text ?? "").isEmpty {
             Utility.alert(title: nil, message: errorMsg, target: self)
             return
         } else if (txtProductCategory.text ?? "").isEmpty {
             
             Utility.alert(title: nil, message: errorMsg, target: self)
             return
         } else if (txtProductSpecification.text ?? "").isEmpty {
             
             Utility.alert(title: nil, message: errorMsg, target: self)
             return
         } else if (txtProductPrice.text ?? "").isEmpty {
            
            Utility.alert(title: nil, message: errorMsg, target: self)
            return
        }
        
        
      let username = UserDefaults.standard.string(forKey: "username")
        
        let parameter = ["productName":productName, "productCompanyName":"NA", "productPrice":productPrice,"userName":username, "productCategory":productCategory, "productDescription":productDesription,"productDimension":productSpecification]
        
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
            //self.dismiss(animated: true, completion: nil)
            Utility.alert(title: nil, message: "Posted", target: self)
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
    
    var selectedCategory : String?
    
    //picker view options
    var categoryType = ["Television","Washing Machine","Air Conditioner","Other Electronics","Funiture","Others"]
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        txtProductCategory.inputView = pickerView
    }
    
    func dismissPickerView()  {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dissmisskeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtProductCategory.inputAccessoryView = toolBar
    }
    
    @objc func dissmisskeyboard()
    {
        view.endEditing(true)
    }
    
    //picker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoryType[row]
        txtProductCategory.text = selectedCategory
        
    }
    // text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
