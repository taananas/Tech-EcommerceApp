//
//  HomeViewModel.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 30.12.2021.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    
    @Published var products: [Product] = [
        
        Product(type: .Wearable,  title: "Apple Watch", subtitle: "Series 6: Grey", price: "$359", productImage: "AppleWatch6"),
        Product(type: .Phones,  title: "iPhone 13", subtitle: "A15 - Blue", price: "$699", productImage: "iPhone13"),
        Product(type: .Laptops,  title: "MacBooc Air", subtitle: "M1 - Space Grey", price: "$999", productImage: "MacBookAir"),
        Product(type: .Tablets,  title: "iPad Pro", subtitle: " A14 - Pink", price: "$699", productImage: "iPadPro"),
        Product(type: .Tablets, title: "iPad Air", subtitle: "iPad Air 2020 Rose Gold", price: "$599", productImage: "iPadAir"),
        Product(type: .Wearable,  title: "AirPods", subtitle: "AirPods - White", price: "$275", productImage: "AirPods"),
        Product(type: .Phones,  title: "iPhone 12", subtitle: "Apple iPhone 12 - Black", price: "$599", productImage: "iPhone12"),

        
    ]
    
    @Published var filteredProducts: [Product] = []
    
    @Published var showMoreProductsOnType: Bool = false
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    var searchCancellable: AnyCancellable?
    
    
    init(){
        filterProductByType()
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter{ product in
                    return product.type == self.productType
                }
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
    func filterProductBySearch(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter{ product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
}
