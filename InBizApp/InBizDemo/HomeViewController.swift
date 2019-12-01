//
//  HomeViewController.swift
//  TabbedApp
//
//  Created by User on 20/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource,HTTRsponseDelegate
    
{
    let client = HTTPClient()
    var displayFirstTime: Bool = true
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var messageLabelNoPost = UILabel()
    var productListAarry = [[String:Any]]()
    var car = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg"]
    var carName = ["item1", "item2", "item3", "item4","item5","item6","item7","item8"]
    @IBOutlet weak var btnPostMessage: UIButton?
    @IBOutlet weak var tableViewCars: UITableView?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollviewHeight: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var btnHome: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSpiner()
        client.delegate = self
        self.btnHome.layer.cornerRadius = 15
        btnPostMessage?.isHidden = true
        messageLabelNoPost.frame = CGRect(x: (UIScreen.main.bounds.size.width - 200) / 2, y: UIScreen.main.bounds.size.height / 2 + 40, width: UIScreen.main.bounds.size.width - 20 , height: 30)
        messageLabelNoPost.text =  "You don't have any post"
        messageLabelNoPost.isHidden = false
        messageLabelNoPost.font = UIFont.systemFont(ofSize: 18.0)
        self.view.addSubview(messageLabelNoPost)
        
        self.tableViewCars?.delegate = self
        self.tableViewCars?.dataSource = self
        
//        if UIScreen.main.bounds.size.height > 768
//        {
//            tableViewCars?.rowHeight = 150;
//        }
        //self.scrollView.frame = CGRect(x: 0, y:0, width:self.view.frame.width, height:200)
        
//        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        
//        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:280))
//        imgOne.image = UIImage(named: "Slide 1")
//        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:280))
//        imgTwo.image = UIImage(named: "Slide 2")
//        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:280))
//        imgThree.image = UIImage(named: "Slide 3")
//        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:280))
//        imgFour.image = UIImage(named: "Slide 4")
//        
//        self.scrollView.addSubview(imgOne)
//        self.scrollView.addSubview(imgTwo)
//        self.scrollView.addSubview(imgThree)
//        self.scrollView.addSubview(imgFour)
//        //4
//        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 4, height:self.scrollView.frame.height)
//        self.scrollView.delegate = self
//        self.pageControl.currentPage = 0
//        
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.btnPostMessage?.isHidden = !(UserDefaults.standard.bool(forKey: "userlogin"))
        
        if(UserDefaults.standard.bool(forKey: "userlogin")) {
            self.messageLabelNoPost.isHidden = true
        }
        
        if(UserDefaults.standard.bool(forKey: "postSuccessful") || UserDefaults.standard.bool(forKey: "userlogin")) {
             UserDefaults.standard.set(false,forKey: "postSuccessful")
            if(displayFirstTime){
                displayFirstTime = false
                getProductList()
            }
            getAllProductWithTimeInterval()
        }
        

            // fix Navigation Bar
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
     
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enquireAction(_ sender: Any) {
        
        let cell = (sender as AnyObject).superview?.superview as? TableViewCell
        
        let indexPath = tableViewCars?.indexPath(for: cell!) as NSIndexPath?
        
//        print(cell,ind)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Enquiry") as! EnquiryViewController
        nextViewController.targetUserName = productListAarry[(indexPath?.row)!]["userName"] as? String
          self.show(nextViewController, sender: self)
    }
    
    @IBAction func FollowAction(_ sender: Any) {
        
        let cell = (sender as AnyObject).superview?.superview as? TableViewCell
        
        let indexPath = tableViewCars?.indexPath(for: cell!) as NSIndexPath?
        
        if(UserDefaults.standard.bool(forKey: "userlogin")) {
            showSpiner()
            let productId = productListAarry[(indexPath?.row)!]["productId"]
            let parameter = ["productId":productId]
            client.MakeRequest(parameters: parameter as [String : Any], url: "http://tst5.jvmhost.net/Inbiz/follow", method: .put
            )
        }
        
        let alert = UIAlertController(title: "Alert", message: "Successfully followed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnPost(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PostForm") as! PostFormViewController
          self.show(nextViewController, sender: self)
    }
    
    @objc func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:200), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //make sure you use the relevant array sizes
        return productListAarry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        messageLabelNoPost.isHidden = true
        let formatter = NumberFormatter()
        var cell : TableViewCell! = tableView.dequeueReusableCell(withIdentifier: "TableCell") as? TableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("TableCell", owner: self, options: nil)?[0] as? TableViewCell;
        }
       
        let prodName = productListAarry[indexPath.row]["productName"] as? String
        cell.lblProdName.text = "Product Name:  \(prodName!)"
        
        let prodCat = productListAarry[indexPath.row]["productCategory"] as? String
        cell.lblProdCategory.text = "Product Category:   \(prodCat!)"
        
        let prodSpecification = productListAarry[indexPath.row]["productDimension"] as? String
        
        cell.lblProdSpecification.text = "Product Summary: \(prodSpecification ?? " ")"
        
        let number = productListAarry[indexPath.row]["productPrice"]
       
         let price = formatter.string(from: number as! NSNumber) ?? ""
        
        cell.lblProductPrice.text = "Product Price:   \(price)"
        
        let numberF: NSInteger = productListAarry[indexPath.row]["productFollowerCount"] as! NSInteger
        
        cell.followCount.text = "(\(formatter.string(from: NSNumber(value: numberF)) ?? ""))"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        nextViewController.productName = productListAarry[indexPath.row]["productName"] as? String
        nextViewController.productSpecification = productListAarry[indexPath.row]["productDimension"] as? String
        nextViewController.productCategory = productListAarry[indexPath.row]["productCategory"] as? String
        nextViewController.productDescription = productListAarry[indexPath.row]["productDescription"] as? String
        
//        self.present(nextViewController, animated: true, completion: nil)
//        func show(_ vc: UIViewController,
//        sender: Any?)
//
//        self.show(nextViewController,)
        
        self.show(nextViewController, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "DetailSegue"
        {
            let detailViewController = ((segue.destination) as! DetailViewController)
            let indexPath = self.tableViewCars!.indexPathForSelectedRow!
            let strImageName = car[indexPath.row]
            detailViewController.strImageName = strImageName
            detailViewController.title = strImageName
        }
    }
    
    
    @objc func handleHTTPRequest() {
        
        // fetch and change the state of data
        let dispatchQueue = DispatchQueue.init(label: "myQueue", qos: .background)
        dispatchQueue.async {
           Alamofire.request("http://tst5.jvmhost.net/Inbiz/allProduct", method: .get, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                if let data = response.result.value as? [[String:Any]]{
                    self.productListAarry = data
                    self.tableViewCars?.reloadData()
                }
            }
           
        }
    }
    
   func getProductList() {
        showSpiner()
        // fetch and change the state of data
        let dispatchQueue = DispatchQueue.init(label: "myQueue", qos: .background)
        dispatchQueue.async {
            Alamofire.request("http://tst5.jvmhost.net/Inbiz/allProduct", method: .get, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    if let data = response.result.value as? [[String:Any]]{
                       self.hideSpiner()
                        self.productListAarry = data
                        self.tableViewCars?.reloadData()
                    }
            }
            
        }
    }
    
    
    func getAllProductWithTimeInterval(){
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(handleHTTPRequest), userInfo: nil, repeats: true)
    }
    
    
    
    func showNetworkError() {
        hideSpiner()
        self.view.makeToast("Please check your network connectivity")
    }
    
    func sendResponseData(data:NSDictionary) {
        
        
        hideSpiner()
        
        guard let code = data["statusCode"] as? NSInteger else {
            
            return
        }
        
        if (code == 200) {
           // Success
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
    
}

private typealias ScrollView = HomeViewController

extension ScrollView
{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            // textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
        }else if Int(currentPage) == 1{
            //textView.text = "I write mobile tutorials mainly targeting iOS"
        }else if Int(currentPage) == 2{
            //textView.text = "And sometimes I write games tutorials about Unity"
        }else{
            //textView.text = "Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            //  UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //    self.startButton.alpha = 1.0
            //})
        }
    }
    
    
}
