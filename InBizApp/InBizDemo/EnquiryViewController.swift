//
//  EnquiryViewController.swift
//  InBizDemo
//
//  Created by Virendra Gupta on 25/11/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class EnquiryViewController: UIViewController,HTTRsponseDelegate {
  

    
    @IBOutlet weak var emailSubject: UITextField!
    
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var enquiryTextView: UITextView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var subject: String!
    var enquiryDetails: String!
    var sourceUserName: String!
    var targetUserName: String!
    
    let client = HTTPClient()
    
    override func viewWillAppear(_ animated: Bool) {
        
        // fix Navigation Bar
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailBtn.layer.cornerRadius = 15
       
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
        
         if (emailSubject.text ?? "").isEmpty {
             Utility.alert(title: nil, message: emptyUserName, target: self)
             return
         } else if (enquiryTextView.text ?? "").isEmpty {
             
             Utility.alert(title: nil, message: emptyPassword, target: self)
             return
         }
         
          client.delegate = self
        
         subject = emailSubject.text
         enquiryDetails = enquiryTextView.text
         sourceUserName = UserDefaults.standard.string(forKey: "username") ?? "username"
        
        
        if (subject != nil) && (enquiryDetails != nil) {
            
//            UserDefaults.standard.set(userId, forKey: "username")
            
            showSpiner()
        
            client.MakeRequest(parameters: ["sourceUser":sourceUserName,"targetUser":targetUserName ,"subject":subject, "mailContent":enquiryDetails], url: "http://tst5.jvmhost.net/Inbiz/mail", method: .post)
        }
    }
    
        func sendResponseData(data:NSDictionary) {
            

            hideSpiner()
           
            
            guard let code = data["statusCode"] as? NSInteger else {
                
                self.view.makeToast(data["response"] as? String)
                
                Utility.alert(title: nil, message:loginErrorMsg , target: self)
                return
            }
            
            if (code == 200) {
                print("Email Sent !")
                Utility.alert(title: nil, message:"Email Sent!" , target: self)
//                UserDefaults.standard.set(true, forKey: "userlogin")
//                UserDefaults.standard.synchronize()
//                self.tabBarController?.selectedIndex = 0
                
       /*         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
    //            self.present(nextViewController, animated:true, completion:nil)
                self.show(nextViewController, sender: self)*/
            }
           
        }
    
    
    func showNetworkError() {
        self.view.makeToast("Please check your network connectivity")
    }
    
    func showSpiner() -> Void {
        self.activityIndicator.startAnimating()
    }

    func hideSpiner() -> Void {
        self.activityIndicator.stopAnimating()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
