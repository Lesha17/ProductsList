//
//  ProductsList.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class ProductList: NSObject, NSCoding {
    var name : String;
    var color : Color = Color.White;
    var completed : Bool = false;
    
    init(name : String) {
        self.name = name;
    }

    convenience init(name : String, color : Color) {
        self.init(name: name);
        self.color = color;
    }

    convenience init(name : String, color : Color, completed : Bool) {
        self.init(name: name, color : color);
        self.completed = completed;
    }
    
    enum Color : Int {
        case Red
        case Green
        case Blue
        case Yellow
        case White
        case Black
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let colorInt = aDecoder.decodeInteger(forKey: "color")
        let color = ProductList.Color(rawValue: colorInt)
        let completed = aDecoder.decodeBool(forKey: "completed")
        self.init(name: name, color: color!, completed: completed)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(color.rawValue, forKey: "color")
        aCoder.encode(completed, forKey: "completed")
    }
}
