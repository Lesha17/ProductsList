//
//  ProductProvider.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

protocol ProductsProvider {
    func getProducts(productListName: String) -> [Product];
    
    func addProduct(productListName: String, product: Product);
    
    func removeProduct(productListName: String, at index : Int);
    
    func reloadProducts(productList: String);
    
    func resaveProducts(productList: String);
}
