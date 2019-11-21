//
//  FirstViewController.swift
//  TabbedApp
//
//  Created by User on 05/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func MyButton(_ sender: Any) {
         NSLog("Inside MyButton click!");
        print("Inside my button")
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func MySignIn(_ sender: Any) {
        
        NSLog("Inside signin..");
        
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! SecondViewController
        self.present(nextViewController, animated:true, completion:nil)    }
}

