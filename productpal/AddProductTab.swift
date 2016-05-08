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
import EventKit

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
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
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
                setReminder()
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
    
    func setReminder(){
        if appDelegate.eventStore == nil {
            appDelegate.eventStore = EKEventStore()
            
            appDelegate.eventStore?.requestAccessToEntityType(
                EKEntityType.Reminder, completion: {(granted, error) in
                    // Access Denied
                    if !granted {
                        print("Access to store not granted")
                        print(error?.localizedDescription)
                        
                        //Access Granted
                    } else {
                        print("Access granted")
                    }
            })
        }
        
        if(appDelegate.eventStore != nil){
            createReminder()
        }
        
    }
    
    func twoDaysPrior(date: NSDate) -> NSDate{
        let newDate:NSDate
        let timeInterval:NSTimeInterval = 60*60*24*(-3)
        newDate = date.dateByAddingTimeInterval(timeInterval)
        return newDate
    }
    
    func createReminder(){
        /** 
         have to check if the any of the dates that show up on the date picker are not the current date to 
         proceed other wise the user will start getting notification for no reason because they didn't know 
         what the warranty date was or they didn't bother getting a protection plan for a bag of dorritos
         
         You have to make this more modular as well. Create diffent methods
         
         This also brings up another issue of when the user updates or makes an edit it an item on the list
         how to remove and create a reminder so we would need access to the reminder database to remove it.
         I really don't want to do that...fuck.
         
        */
        
        //Check if the date on the date picker is the current date
        if(!isCurrentDateTheSameAs(returnDate.date)){
            createReminderFor(returnDate.date, title: "Don't forget the last day to return \(itemName.text!) is on ")
        }
        
        if(!isCurrentDateTheSameAs(warrantyDate.date)){
            createReminderFor(warrantyDate.date, title: "Don't forget your warranty for \(itemName.text!) ends on ")
        }
        if(!isCurrentDateTheSameAs(protectionDate.date)){
            createReminderFor(protectionDate.date, title: "Don't forget your protection for \(itemName.text!) ends on ")
        }
        
        
    }
    func isCurrentDateTheSameAs(testDate: NSDate) -> Bool{
        var isSameDate = false
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        // Used for Debugging
        print(year)
        print(month)
        print(day)
        
        let testDateComponents = calendar.components([.Day, .Month, .Year], fromDate: testDate)
        let testYear = testDateComponents.year
        let testMonth = testDateComponents.month
        let testDay = testDateComponents.day
        
        print(testYear)
        print(testMonth)
        print(testDay)
        
        if(testDay == year && testMonth == month && testDay == day){
            isSameDate = true
        }
        
        
        return isSameDate
    }
    
        
        
    func createReminderFor(reminderDate: NSDate, title: String){
        let reminder = EKReminder(eventStore: appDelegate.eventStore!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM d yyyy"
        let dateString = dateFormatter.stringFromDate(reminderDate)
        reminder.title = "\(title) \(dateString)"
        
        reminder.calendar = appDelegate.eventStore!.defaultCalendarForNewReminders()
        
        var date = returnDate.date
        var alarm = EKAlarm(absoluteDate: date)
        reminder.addAlarm(alarm)
        date = twoDaysPrior(returnDate.date)
        alarm = EKAlarm(absoluteDate: date)
        reminder.addAlarm(alarm)
        
        
        do{
            try appDelegate.eventStore?.saveReminder(reminder, commit: true)
        }
        catch let error as NSError{
            print("Failed to add reminder with error \(error.localizedFailureReason)")
        }
        
    }
 
    
    
    
    
}
