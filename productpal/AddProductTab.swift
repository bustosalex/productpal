//
//  AddProductTab.swift
//  productpal
//
//  Created by Alexander Bustos on 5/5/16.
//  Copyright © 2016 University of Wisconsin Parkisde. All rights reserved.
//


import UIKit
import CoreData
import RealmSwift

class AddProductTab: UITableViewController {
    //These are the attributes for the core data model
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var productNumber: UITextField!
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var returnDate: UIDatePicker!
    @IBOutlet weak var warrantyDate: UIDatePicker!
    @IBOutlet weak var protectionDate: UIDatePicker!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    /**
     When the user hits save or done it will first check to see if the text fields are filled properly other wise it will 
     throw an error message. 
     Then we begin to save the name, description, store, and all of the relevant dates into a core data object. 
    */
    
    @IBAction func saveProduct(sender: AnyObject) {
        
        let check = checkIfShitIsFilledOut()
        
        if(check != true){
            fieldsNotFilledErrorMessage()
        }
        else{
            let realm = try! Realm()
            let newProduct = ProductModel()
            
            newProduct.name = itemName.text!
            newProduct.store = storeName.text!
            newProduct.desc = itemDescription.text!
            newProduct.returnDate = returnDate.date
            newProduct.warrantyDate = warrantyDate.date
            newProduct.protectionDate = protectionDate.date
            
            
            try! realm.write {
                realm.add(newProduct)
                print("Saved your shit. \(newProduct.name)")
            }

        }
                
        
    }
    /**
        This function checks if three text fields are filled 
        The name of the item, it's description and the store where it was bought
        If any of these fields are empty then it will return false other wise it
        will return true.
    */
    func checkIfShitIsFilledOut()->Bool{
        var isFilled = true
        if ((itemName.text?.isEmpty) != false){
            isFilled = false
        }
        else if((itemDescription.text?.isEmpty) != false){
            isFilled = false
        }
        else if((storeName.text?.isEmpty) != false){
            isFilled = false
        }
        return isFilled
        
    }
    /**
        This is a simple method that pops up an error message if a required field isn't properly filled
    */
    func fieldsNotFilledErrorMessage(){
        let alert = UIAlertController(title: "Error", message: "You didn't fill everything in!!!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
    }
    
    
    func createReminder(){
        
    }
    
}
