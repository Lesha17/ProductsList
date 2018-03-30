//
//  AddProductViewController.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class AddProductViewController: UITableViewController {
    var product : Product?
    
    @IBOutlet weak var nameText: UITextField!
    
}

extension AddProductViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DoneCreateProduct"{
            product?.name = nameText.text ?? ""
        }
    }
}
