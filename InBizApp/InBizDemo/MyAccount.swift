//
//  MyAccount.swift
//  InBizDemo
//
//  Created by Ravindra on 02/09/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class MyAccount: UIViewController {
    
    @IBOutlet weak var firstLastNameLbl: UILabel!
    
    @IBOutlet weak var signInmessge: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var enterprise: UILabel!
    @IBOutlet weak var enterpriceTitle: UILabel!
    
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet var myAccountView: UIView!
    @IBOutlet weak var webUrlTitleLbl: UILabel!
    
    @IBOutlet weak var webUrlTextLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if(UserDefaults.standard.bool(forKey: "userlogin")) {
            myAccountView.isHidden = false
            signInmessge.isHidden = true  //lastname
            let firstName = UserDefaults.standard.string(forKey: "username") ?? "username"
            firstLastNameLbl.text = String(format: "%@ %@", usrfname, usrlname)
            usernameText.text = firstName
            emailText.text =  UserDefaults.standard.string(forKey: "email") ?? "usrname@gmail.com"
            enterprise.text = userTypeStr
            
            if (userTypeStr == "Consumer") {
                webUrlTextLbl.isHidden = true
                webUrlTitleLbl.isHidden = true
                
                enterprise.frame.origin.y -= 30
                enterpriceTitle.frame.origin.y -= 30
                
            }
            else{
                webUrlTextLbl.isHidden = false
                webUrlTitleLbl.isHidden = false
                
                webUrlTextLbl.text = webUrl
            }
            
        }
        else {
            myAccountView.isHidden = true
            signInmessge.isHidden = false
        }
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
