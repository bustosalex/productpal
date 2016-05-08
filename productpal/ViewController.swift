//
//  ViewController.swift
//  productpal
//
//  Created by Francisco Mateo on 4/6/16.
//  Copyright © 2016 University of Wisconsin Parkisde. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        let collection = try! Realm().objects(ProductModel)
        return collection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Product Cell") as! CustomCell
        let allProducts = try! Realm().objects(ProductModel)
        let product = allProducts[indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        
        cell.itemName.text = product.name
        var dateString = dateFormatter.stringFromDate(product.returnDate!)
        cell.returnDate.text = dateString
        dateString = dateFormatter.stringFromDate(product.protectionDate!)
        cell.protectionDate.text = dateString
        dateString = dateFormatter.stringFromDate(product.warrantyDate!)
        cell.warranyDate.text = dateString
        
        
        cell.itemImage!.image = UIImage(named: "canon")
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

}

