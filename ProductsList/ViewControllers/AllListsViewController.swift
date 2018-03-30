//
//  AllListsViewController.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    static let TODO_SECTION = 0
    static let DONE_SECTION = 1
    
    var productListsProvider : ProductListsProvider = OfflineProductListsProvider()
}

extension AllListsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case AllListsViewController.TODO_SECTION:
            return "TODO"
        case AllListsViewController.DONE_SECTION:
            return "Done"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case AllListsViewController.TODO_SECTION:
            return getLists(completed: false).count
        case AllListsViewController.DONE_SECTION:
            return getLists(completed: true).count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completed : Bool = (indexPath.section == AllListsViewController.DONE_SECTION)
        let lists = getLists(completed: completed)
        let list : ProductList = lists[indexPath.row]
        
        list.completed = !list.completed
        
        productListsProvider.resaveLists()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let completed : Bool = (indexPath.section == AllListsViewController.DONE_SECTION)
        let lists = getLists(completed: completed)
        let list = lists[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as? UITableViewCell
        cell?.textLabel?.text = list.name
        switch list.color {
        case ProductList.Color.Red:
            cell?.backgroundColor = UIColor.red
            break
        case ProductList.Color.Green:
            cell?.backgroundColor = UIColor.green
            break
        case ProductList.Color.Blue:
            cell?.backgroundColor = UIColor.blue
            cell?.textLabel?.textColor = UIColor.white
            break
        case ProductList.Color.Yellow:
            cell?.backgroundColor = UIColor.yellow
            break
        case ProductList.Color.White:
            cell?.backgroundColor = UIColor.white
            break
        case ProductList.Color.Black:
            cell?.backgroundColor = UIColor.black
            cell?.textLabel?.textColor = UIColor.white
            break
        default:
            break
        }
        
        return cell!

    }
    
    func getLists(completed : Bool) -> [ProductList] {
        var result : [ProductList] = [];
        
        for var productList in productListsProvider.getProductLists() {
            if (productList.completed == completed) {
                result.append(productList)
            }
        }
        
        return result
    }
}

extension AllListsViewController {
    @IBAction func cancelCreateListToAllLists(_ segue : UIStoryboardSegue){
        
    }
    
    @IBAction func doneCreateListToAllLists(_ segue : UIStoryboardSegue){
        if let createListViewController = segue.source as? CreateListViewController {
            let listToAdd = createListViewController.productList
            productListsProvider.addProductList(productList: listToAdd)
                
            tableView.reloadData()
        }
    }
    
    @IBAction func backFromViewListToAllLists(_ segue : UIStoryboardSegue) {
        
    }
}
