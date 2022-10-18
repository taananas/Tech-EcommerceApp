//
//  Home.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 30.12.2021.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    @EnvironmentObject var sharedData: SharedDataModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(spacing: 15){
                ZStack{
                    if homeData.searchActivated{
                        searchBar()
                    }else{
                        searchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture{
                    withAnimation(.easeOut){
                        homeData.searchActivated = true
                    }
                }
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 30).bold())
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18){
                        ForEach(ProductType.allCases, id: \.self){ type in
                            productTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25){
                        ForEach(homeData.filteredProducts){product in
                            productCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 50)
                
                Button{
                    homeData.showMoreProductsOnType.toggle()
                }label: {
                    Label{
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color("Purple"))
                    } icon: {
                        Text("See more")
                            .font(.custom(customFont, size: 15).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top,10)
                }
                
            }
            .padding(.vertical)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        
        .onChange(of: homeData.productType){ newValue in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType){
            
        }content: {
            MoreProduct()
        }
        .overlay(
            ZStack{
                if homeData.searchActivated{
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )
    }
    
    @ViewBuilder
    func productCardView(product:Product) -> some View{
        VStack(spacing: 10){
            
            ZStack{
                if sharedData.showDetailProduct {
                    
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5 , height: getRect().width / 2.5)
            .offset(y: -80)
            .padding(.bottom, -80)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 18).bold())
                .foregroundColor(Color("Purple"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.datailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    
    @ViewBuilder
    func productTypeView(type: ProductType) -> some View {
        Button{
            withAnimation{
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color("Purple") : Color.gray)
                .padding(.bottom, 10)
                .overlay(
                    ZStack{
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    ,alignment: .bottom
                )
        }
    }
    @ViewBuilder
    func searchBar() -> some View{
        
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            
        Capsule()
            .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}


