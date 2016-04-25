//
//  CustomCell.swift
//  productpal
//
//  Created by Alexander Bustos on 4/25/16.
//  Copyright © 2016 University of Wisconsin Parkisde. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    // instance variable for all the elements displaye in the cell
    
    @IBOutlet weak var itemImage: UIImageView?
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var warranyDate: UILabel!
    @IBOutlet weak var protectionDate: UILabel!
    
    @IBOutlet weak var returnDate: UILabel!
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //    }
    //    override func setSelected(selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //        
    //    }
}
