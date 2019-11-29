//
//  ThirdViewController.swift
//  TabbedApp
//
//  Created by User on 19/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,HTTRsponseDelegate, UITextFieldDelegate {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var fnameTextField: UITextField!
    
    @IBOutlet weak var lnameTextField: UITextField!
    
    @IBOutlet weak var supliernameTextField: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var firstname: String!
    var lastname: String!
    var enterprisename: String!
    var username: String!
    
    var emailId: String!
    var password: String!
    var confirmPassword: String!
    var supliername: String!
    
    
    
    @IBOutlet weak var picker: UIPickerView!
    
   
    
    var pickerData : [String] = [String]()
    var selectedCategory : String?
    
    let client = HTTPClient()
    
    override func viewWillAppear(_ animated: Bool) {
        // fix Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSubmit.layer.cornerRadius = 15
        pickerData = ["Consumer","Manufacturer/Supplier"]
//        self.picker.delegate = self
//        self.picker.dataSource = self
        addSpiner()
        client.delegate = self
//        supliernameTextField.text = pickerData[0]
        if pickerData[0] == "Consumer" {
            supliernameTextField.isHidden = true
        }
        
        
        //adding picker view to the textfield
        createPickerView()
        dismissPickerView()
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //picker view options
    var categoryType = ["Television","Washing Machine","Air Conditioner","Other Electronics","Funiture","Others"]
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        pickerTextField.inputView = pickerView
        
    }
    
    func dismissPickerView()  {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dissmisskeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pickerTextField.inputAccessoryView = toolBar
    }
    
    @objc func dissmisskeyboard()
    {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    


    @IBAction func registrationButtonAction(_ sender: Any) {
        
        if (emailTextField.text ?? "").isEmpty {
            Utility.alert(title: nil, message: "Please enter email", target: self)
            return
        } else if (userTextField.text ?? "").isEmpty {
            Utility.alert(title: nil, message: "Please enter email", target: self)
            return
        } else if (fnameTextField.text ?? "").isEmpty && !fnameTextField.isHidden{
            Utility.alert(title: nil, message: "Please enter first name", target: self)
            return
        } else if (lnameTextField.text ?? "").isEmpty && !lnameTextField.isHidden {
            
            Utility.alert(title: nil, message: "Please enter last name", target: self)
            return
        } else if (passwordTextField.text ?? "").isEmpty {
            
            Utility.alert(title: nil, message: "Please enter password", target: self)
            return
        } else if (confirmPasswordTextField.text ?? "").isEmpty {
            
            Utility.alert(title: nil, message: "Please enter confirm password", target: self)
            return
        } else if (supliernameTextField.text ?? "").isEmpty && !supliernameTextField.isHidden{
            
           Utility.alert(title: nil, message: "Please enter suplier name", target: self)
           return
        }
        
       
        username = userTextField.text!
        firstname = fnameTextField.text!
        lastname = lnameTextField.text!
        supliername = supliernameTextField.text!
        emailId = emailTextField.text!
        password = passwordTextField.text!
        confirmPassword = confirmPasswordTextField.text!
        
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(emailId, forKey: "email")
        UserDefaults.standard.set(supliername, forKey: "supliername")
        
        if (password != nil) && (confirmPassword != nil) && (password != confirmPassword) {
            Utility.alert(title: nil, message: "Password doesn't match", target: self)
            return
        }
        
        showSpiner()
        
        client.MakeRequest(parameters: ["firstname": firstname,"lastname": lastname ,"age":"38","userId":username,"mobile":"999999999","password":password,"userType":supliername], url: "http://tst5.jvmhost.net/Inbiz/createUser", method: .post)
      
    }
    
    
    @IBAction func backAction(_ sender: Any) {
         //UserDefaults.standard.set(true, forKey: "fromRegistration")
         self.dismiss(animated: true, completion: nil)
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! PostFormViewController
//          self.show(nextViewController, sender: self)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        supliernameTextField.text = pickerData[row]
        if pickerData[row] == "Consumer" {
            supliernameTextField.isHidden = true
            fnameTextField.isHidden = false
            lnameTextField.isHidden = false
        }
        else {
            supliernameTextField.isHidden = false
            supliernameTextField.frame = CGRect(x: supliernameTextField.frame.origin.x, y: fnameTextField.frame.origin.y , width: supliernameTextField.frame.size.width, height: supliernameTextField.frame.size.height)
            fnameTextField.isHidden = true
            lnameTextField.isHidden = true
        }
        
                  selectedCategory = pickerData[row]
                  pickerTextField.text = selectedCategory
                 supliername = selectedCategory
    }

    
    func showNetworkError() {
        hideSpiner()
        self.view.makeToast("Please check your network connectivity")
        self.dismiss(animated: true, completion: nil)
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
    
    func sendResponseData(data:NSDictionary) {
        
        hideSpiner()
        guard let code = data["statusCode"] as? NSInteger else {
//            self.view.makeToast(data["response"] as? String)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            //            self.present(nextViewController, animated:true, completion:nil)
            self.show(nextViewController, sender: self)
            return
        }
        
        if (code == 200) {
            print("Registration Successful!")
            //self.dismiss(animated: true, completion: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
            //            self.present(nextViewController, animated:true, completion:nil)
            self.show(nextViewController, sender: self)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // text field delegate
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    
}

