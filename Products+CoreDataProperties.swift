//
//  Products+CoreDataProperties.swift
//  productpal
//
//  Created by Alexander Bustos on 5/5/16.
//  Copyright © 2016 University of Wisconsin Parkisde. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Products {
    @NSManaged var productNumber: String?
    @NSManaged var itemDescription: String?
    @NSManaged var itemName: String?
    @NSManaged var notes: String?
    @NSManaged var productName: String?
    @NSManaged var protectionDate: NSDate?
    @NSManaged var returnDate: NSDate?
    @NSManaged var store: String?
    @NSManaged var warrantyDate: NSDate?

}
