//
//  OfflineProductListsProvider.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

class OfflineProductListsProvider: ProductListsProvider {
    static let productListsKey = "product_lists_key"
    
    var productLists : [ProductList]?
    
    func getProductLists() -> [ProductList]{
        if(productLists == nil) {
            let userDefaults = UserDefaults.standard;
            let decoded : Data? = userDefaults.object(forKey: OfflineProductListsProvider.productListsKey) as? Data;
            if(decoded != nil){
                productLists = (NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [ProductList])
            } else {
                productLists = []
            }
        }
        
        return productLists!;
    }
    
    func addProductList(productList : ProductList){
        productLists = getProductLists()
        productLists!.append(productList)
        
        resaveLists()
    }
    
    func removeProductList(at index : Int) {
        productLists = getProductLists()
        productLists!.remove(at: index)
    
        resaveLists();
    }
    
    func reloadLists() {
        productLists = nil
        productLists = getProductLists()
    }
    
    func resaveLists() {
        let productLists = getProductLists()
        
        let userDefaults = UserDefaults.standard;
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: productLists);
        userDefaults.set(encodedData, forKey: OfflineProductListsProvider.productListsKey);
        userDefaults.synchronize();
    }
}
