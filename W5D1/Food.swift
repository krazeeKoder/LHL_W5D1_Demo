//
//  Food.swift
//  W5D1
//
//  Created by Erin Luu on 2017-11-28.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import Foundation
import Parse

class Food: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var price: Int
    
    convenience init(name: String, price: Int){
        self.init()
        self.name = name
        self.price = price
    }
    
    static func parseClassName() -> String {
        return "Food"
    }
    
}

