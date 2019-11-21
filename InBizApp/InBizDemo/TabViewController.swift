//
//  TabViewController.swift
//  InBizDemo
//
//  Created by Ravindra on 02/09/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
        
    }
    
    func setUp() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        
        let storyBoard1 : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController1 = storyBoard1.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        
        let storyBoard2 : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController3 = storyBoard2.instantiateViewController(withIdentifier: "MyAccount") as! MyAccount
        
        
        let firstViewController = nextViewController
        
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondViewController = nextViewController1
        
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let thirdViewController = nextViewController3
        
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController]
        
        viewControllers = tabBarList
       
    }
    

}
