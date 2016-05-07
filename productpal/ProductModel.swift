//
//  ProductModel.swift
//  productpal
//
//  Created by Alexander Bustos on 5/7/16.
//  Copyright © 2016 University of Wisconsin Parkisde. All rights reserved.
//

import Foundation
import RealmSwift

class ProductModel: Object{
    dynamic var name = ""
    dynamic var productNumber = 0
    dynamic var store = ""
    dynamic var desc = ""
    dynamic var returnDate: NSDate?
    dynamic var warrantyDate: NSDate?
    dynamic var protectionDate: NSDate?
}
