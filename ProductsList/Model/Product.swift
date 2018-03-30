//
//  Product.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class Product: NSObject, NSCoding {
    var name : String;
    var productListName : String;
    var completed : Bool = false;
    
    init(name : String, productListName : String) {
        self.name = name;
        self.productListName = productListName;
    }
    
    convenience init(name : String, productListName : String, completed : Bool) {
        self.init(name: name, productListName : productListName);
        self.completed = completed;
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let productListName = aDecoder.decodeObject(forKey: "productListName") as! String
        let completed = aDecoder.decodeBool(forKey: "completed")
        self.init(name: name, productListName : productListName, completed: completed)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(productListName, forKey: "productListName")
        aCoder.encode(completed, forKey: "completed")
    }
}
