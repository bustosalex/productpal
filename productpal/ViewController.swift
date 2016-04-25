//
//  ViewController.swift
//  productpal
//
//  Created by Francisco Mateo on 4/6/16.
//  Copyright © 2016 University of Wisconsin Parkisde. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Product Cell") as! CustomCell
        cell.itemName.text = "Cock"
        cell.itemImage!.image = UIImage(named: "canon")
        cell.returnDate.text = "5/25/16"
        cell.protectionDate.text = "5/25/17"
        cell.warranyDate.text = "12/25/16"
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

}

