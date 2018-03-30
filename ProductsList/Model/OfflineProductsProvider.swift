//
//  OfflineProductProvider.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class OfflineProductsProvider: NSObject, ProductsProvider {
    
    static let allProductsKey = "all_products_key"
    
    var allProducts : [Product]?
    
    func getProducts(productListName: String) -> [Product] {
        var result : [Product] = []
        
        for var p in getAllProducts() {
            if p.productListName == productListName {
                result.append(p)
            }
        }
        
        return result
    }
    
    func getAllProducts() -> [Product] {
        if(allProducts == nil) {
            let userDefaults = UserDefaults.standard;
            let decoded : Data? = userDefaults.object(forKey: OfflineProductsProvider.allProductsKey) as? Data;
            if(decoded != nil){
                allProducts = (NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Product])
            } else {
                allProducts = []
            }
        }
        
        return allProducts!;
    }
    
    func addProduct(productListName: String, product: Product) {
        allProducts = getAllProducts()
        allProducts!.append(product)
        
        resaveProducts(productList: productListName)
    }
    
    func removeProduct(productListName: String, at index: Int) {
        allProducts = getAllProducts()
        var actualndex = 0;
        var indexWithinProductList = 0;
        
        while (indexWithinProductList != index) {
            if allProducts![actualndex].productListName == productListName {
                indexWithinProductList = indexWithinProductList + 1
            }
            actualndex = actualndex + 1
        }
        
        allProducts!.remove(at: actualndex)
        
        resaveProducts(productList: productListName)
    }
    
    func reloadProducts(productList: String) {
        allProducts = nil
        allProducts = getProducts(productListName: productList)
    }
    
    func resaveProducts(productList: String) {
        let allProducts = getAllProducts()
        
        let userDefaults = UserDefaults.standard;
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: allProducts);
        userDefaults.set(encodedData, forKey: OfflineProductsProvider.allProductsKey);
        userDefaults.synchronize();
    }
}
