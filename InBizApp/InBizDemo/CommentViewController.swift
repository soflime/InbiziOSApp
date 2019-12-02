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
    var productId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func commentBtnAction(_ sender: Any) {
         if (commentTextfield.text ?? "").isEmpty {
             Utility.alert(title: nil, message: emptyUserName, target: self)
             return
         }
         
        client.delegate = self
        comment = commentTextfield.text
         
       if (comment != nil) {
             
//             UserDefaults.standard.set(userId, forKey: "username")
             
             showSpiner()
         
             client.MakeRequest(parameters: ["productId":"5", "comments":comment], url: "http://tst5.jvmhost.net/Inbiz/comment", method: .post)
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
                
//                Utility.alert(title: nil, message:loginErrorMsg , target: self)
                return
            }
            
            if (code == 200) {
                print("commented Successful!")
                
                Utility.alert(title: nil, message:"Comment posted !" , target: self)
                
               // self.dismiss(animated: true, completion: nil)
//
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//    //            self.present(nextViewController, animated:true, completion:nil)
//                self.show(nextViewController, sender: self)
            }
           
        }
    
    func showSpiner() -> Void {
        self.activityIndicator.startAnimating()
    }

    func hideSpiner() -> Void {
        self.activityIndicator.stopAnimating()
    }

}
