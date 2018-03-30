//
//  CreateListViewController.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class CreateListViewController: UITableViewController {
    var productList : ProductList = ProductList(name: "");
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    @IBAction func colorButtonTouch(_ sender: UIButton) {
        var colorButtons : [UIButton] = [redButton, greenButton, blueButton, yellowButton, whiteButton, blackButton]
        colorButtons.remove(at: colorButtons.index(of: sender)!)
        
        for var button in colorButtons {
            button.isSelected = false
        }
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            switch sender {
            case redButton:
                productList.color = ProductList.Color.Red
                break
            case greenButton:
                productList.color = ProductList.Color.Green
                break
            case blueButton:
                productList.color = ProductList.Color.Blue
                break
            case yellowButton:
                productList.color = ProductList.Color.Yellow
                break
            case whiteButton:
                productList.color = ProductList.Color.White
                break
            case blackButton:
                productList.color = ProductList.Color.Black
                break
            default: break
            }
        } else {
            productList.color = ProductList.Color.White
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DoneCreateProductList"{
            productList.name = nameField.text ?? ""
        }
    }
    
}
