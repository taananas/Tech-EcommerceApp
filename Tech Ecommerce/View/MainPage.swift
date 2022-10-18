//
//  MainPage.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 30.12.2021.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab: Tab = .Home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    @Namespace var animation
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        VStack(spacing: 0){
            
            TabView(selection: $currentTab){
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                Liked()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                Profile()
                    .tag(Tab.Profile)
                Cart()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
            }
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.self){ tab in
                    Button {
                        currentTab = tab
                    }label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                        
                            .background(
                                Color("Purple")
                                    .opacity(0.1)
                                    .cornerRadius(10)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                                
                            )
                        
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Purple") : Color.black.opacity(0.3))
                        
                        
                    }
                }
                .padding([.horizontal, .bottom])
                .padding(.bottom, 10)
            }
        }
        .background(Color("HomeBG").ignoresSafeArea())
        
        .overlay{
            ZStack{
                if let product = sharedData.datailProduct,sharedData.showDetailProduct{
                    
                    ProductDetailView(animation: animation, product: product)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String, CaseIterable {
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
    
    
}
