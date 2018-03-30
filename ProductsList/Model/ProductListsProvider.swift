//
//  ProductListsProvider.swift
//  ProductsList
//
//  Created by Алексей Мачнев on 30/03/2018.
//  Copyright © 2018 HSE. All rights reserved.
//

import UIKit

protocol ProductListsProvider {
    func getProductLists() -> [ProductList];
    
    func addProductList(productList: ProductList);
    
    func removeProductList(at index : Int);
    
    func reloadLists();
    
    func resaveLists();
}
