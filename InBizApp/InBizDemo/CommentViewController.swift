//
//  CommentViewController.swift
//  InBizDemo
//
//  Created by Virendra Gupta on 02/12/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController,HTTRsponseDelegate {

    @IBOutlet weak var commentTextfield: UITextField!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let client = HTTPClient()
    var comment: String!
    var productId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func commentBtnAction(_ sender: Any) {
         if (commentTextfield.text ?? "").isEmpty {
             Utility.alert(title: nil, message: "Please enter comment", target: self)
             return
         }
         
        client.delegate = self
        comment = commentTextfield.text
         
       if (comment != nil) {
             
//             UserDefaults.standard.set(userId, forKey: "username")
             
             showSpiner()
         
             client.MakeRequest(parameters: ["productId":productId, "comments":comment], url: "http://tst5.jvmhost.net/Inbiz/comment", method: .post)
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
     func showNetworkError() {
            hideSpiner()
            self.view.makeToast("Please check your network connectivity")
        }
        
        func sendResponseData(data:NSDictionary) {
            

            hideSpiner()
           
            
            guard let code = data["httpstatus"] as? NSInteger else {
                
                self.view.makeToast(data["response"] as? String)
            
                return
            }
            
            if (code == 200) {

                navigationController?.popViewController(animated: true)

                dismiss(animated: true, completion: nil)

            }
           
        }
    
    func showSpiner() -> Void {
        self.activityIndicator.startAnimating()
    }

    func hideSpiner() -> Void {
        self.activityIndicator.stopAnimating()
    }

}
