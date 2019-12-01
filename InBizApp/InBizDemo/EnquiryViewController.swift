//
//  EnquiryViewController.swift
//  InBizDemo
//
//  Created by Virendra Gupta on 25/11/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class EnquiryViewController: UIViewController {
    @IBOutlet weak var emailSubject: UITextField!
    
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var enquiryTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailBtn.layer.cornerRadius = 15
       
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
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
