//
//  SharedDataModel.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 01.01.2022.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    @Published var datailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    @Published var fromSearchPage: Bool = false
    
    
    @Published var likedProducts: [Product] = []
    
    @Published var cartProducts: [Product] = []
    
    func getTotalPrice() -> String{
        var total: Int = 0
        
        cartProducts.forEach{ product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return "$\(total)"
    }
}

