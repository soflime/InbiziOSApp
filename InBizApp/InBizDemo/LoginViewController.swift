//
//  SecondViewController.swift
//  TabbedApp
//
//  Created by User on 05/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

let loginErrorMsg = "Invalid Credentials. Kindly check user name and password "

class LoginViewController: UIViewController,HTTRsponseDelegate, UITextFieldDelegate {

    @IBOutlet weak var useridField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var regButton: UIButton!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var userId: String!
    var pwd: String!
    let client = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.layer.cornerRadius = 15
        self.regButton.layer.cornerRadius = 15
        addSpiner()
        client.delegate = self
        
        useridField.delegate = self
        pwdField.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if (UserDefaults.standard.bool(forKey: "fromRegistration")){
            UserDefaults.standard.set(false, forKey: "fromRegistration")
            useridField.text = ""
            pwdField.text = ""
            
        }
        
        navigationController?.isNavigationBarHidden = true
        
        
    }

    @IBAction func signInOrRegisterButton(_ sender: Any) {
        
        NSLog("Inside signIN or Register button click!");
    }
    
    @IBAction func registerWithUsButton(_ sender: Any) {
    
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Registration") as! RegistrationViewController
//        self.present(nextViewController, animated:true, completion:nil)
       self.show(nextViewController, sender: self)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        if (useridField.text ?? "").isEmpty {
            Utility.alert(title: nil, message: loginErrorMsg, target: self)
            return
        } else if (pwdField.text ?? "").isEmpty {
            
            Utility.alert(title: nil, message: loginErrorMsg, target: self)
            return
        }
       
        userId = useridField.text
        pwd = pwdField.text
        
        if (userId != nil) && (pwd != nil) {
            
            UserDefaults.standard.set(userId, forKey: "username")
            
            showSpiner()
        
            client.MakeRequest(parameters: ["userId":userId, "password":pwd], url: "http://tst5.jvmhost.net/Inbiz/getUserInfo", method: .post)
        }
        
       
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
   
    @IBAction func ForgetPwd(_ sender: Any) {
        
        NSLog("Inside Forget password button click!");
        
    }
    
    func showNetworkError() {
        hideSpiner()
        UserDefaults.standard.set(false, forKey: "userlogin")
        self.tabBarController?.selectedIndex = 0
        self.view.makeToast("Please check your network connectivity")
    }
    
    func sendResponseData(data:NSDictionary) {
        

        hideSpiner()
       
        guard let code = data["statusCode"] as? NSInteger else {
            self.view.makeToast(data["response"] as? String)
            return
        }
        
        if (code == 200) {
            print("Login Successful!")
            UserDefaults.standard.set(true, forKey: "userlogin")
            UserDefaults.standard.synchronize()
            self.tabBarController?.selectedIndex = 0
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
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
