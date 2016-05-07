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
        
        cell.itemName.text = product.name
        cell.returnDate.text = "5/5/17"
        cell.protectionDate.text = "5/5/17"
        cell.warranyDate.text = "5/5/17"
        cell.itemImage!.image = UIImage(named: "canon")
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

}

