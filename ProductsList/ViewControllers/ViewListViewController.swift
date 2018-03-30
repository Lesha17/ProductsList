//
//  ViewListViewController.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class ViewListViewController: UITableViewController {
    static let TODO_SECTION = 0
    static let DONE_SECTION = 1
    
    var productsProvider : ProductsProvider = OfflineProductsProvider()
    var productListName : String = ""
}

extension ViewListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case ViewListViewController.TODO_SECTION:
            return "TODO"
        case ViewListViewController.DONE_SECTION:
            return "Done"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case ViewListViewController.TODO_SECTION:
            return getProducts(completed: false).count
        case ViewListViewController.DONE_SECTION:
            return getProducts(completed: true).count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completed : Bool = (indexPath.section == ViewListViewController.DONE_SECTION)
        let products = getProducts(completed: completed)
        let product : Product = products[indexPath.row]
        
        product.completed = !product.completed
        
        productsProvider.resaveProducts(productList: productListName)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let completed : Bool = (indexPath.section == ViewListViewController.DONE_SECTION)
        let products = getProducts(completed: completed)
        let product = products[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? UITableViewCell
        cell?.textLabel?.text = product.name

        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete {
            let allProducts = productsProvider.getProducts(productListName: productListName);
            let completed : Bool = (indexPath.section == AllListsViewController.DONE_SECTION)
            let products = getProducts(completed: completed)
            let product = products[indexPath.row]
            let index = allProducts.index(of: product)
            
            productsProvider.removeProduct(productListName: productListName, at: index!);
            
            tableView.reloadData()
        }
    }
    
    func getProducts(completed : Bool) -> [Product] {
        var result : [Product] = [];
        
        for var product in productsProvider.getProducts(productListName: productListName) {
            if (product.completed == completed) {
                result.append(product)
            }
        }
        
        return result
    }
}

extension ViewListViewController {
    @IBAction func cancelToViewList(_ segue : UIStoryboardSegue){
        
    }
    
    @IBAction func doneCreateProduct(_ segue : UIStoryboardSegue){
        if let addProductViewController = segue.source as? AddProductViewController {
            if let productToAdd = addProductViewController.product {
                productsProvider.addProduct(productListName: productListName, product: productToAdd)
                
                tableView.reloadData()
            }
        }
    }
}

extension ViewListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddProduct" {
            if let navigationController = segue.destination as? UINavigationController {
                if let addProductController = navigationController.topViewController as? AddProductViewController {
                    addProductController.product = Product(name: "", productListName: productListName)
                }
            }
        }
    }
}
