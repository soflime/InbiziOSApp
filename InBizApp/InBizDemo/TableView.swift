//
//  TableView.swift
//  TabbedApp
//
//  Created by User on 27/08/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class TableView: UIViewController {

    var car = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg"]
    var carName = ["item1", "item2", "item3", "item4","item5","item6","item7","item8"]
    
    @IBOutlet weak var tvCars: UITableView?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if UIScreen.main.bounds.size.height>768
        {
            tvCars?.rowHeight=100;
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableview delegate
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //make sure you use the relevant array sizes
        return car.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        var cell : TableViewCell! = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("TableCell", owner: self, options: nil)?[0] as! TableViewCell;
        }
        let stringTitle = carName[indexPath.row] as String //NOT NSString
        let strCarName = car[indexPath.row] as String
        //cell.lblDesc.text=stringTitle
       // cell.ivPhoto.image = UIImage(named: strCarName)
        return cell as TableViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "DetailSegue"
        {
            let detailViewController = ((segue.destination) as! DetailViewController)
            let indexPath = self.tvCars!.indexPathForSelectedRow!
            let strImageName = car[indexPath.row]
            detailViewController.strImageName = strImageName
            detailViewController.title = strImageName
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /* var fruitsData = ["Apple", "Banana", "Banana", "Apple" , "Apple" , "Banana"]
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let fruitName = fruitsData[indexPath.row]
        cell.textLabel?.text = fruitName
        cell.detailTextLabel?.text = "Fruit..!"
        cell.imageView?.image = UIImage(named: fruitName)
        return cell
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
