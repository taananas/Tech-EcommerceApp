//
//  Liked.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 01.01.2022.
//

import SwiftUI

struct Liked: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteLiked: Bool = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HStack{
                    Text("Favorites")
                        .font(.custom(customFont, size: 28).bold())
                    Spacer()
                        Button{
                            withAnimation{
                                showDeleteLiked.toggle()
                            }
                        }label: {
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    
                    if sharedData.likedProducts.isEmpty{
                        Group{
                            Image("EmptyLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top,35)
                            Text("No favorites yet")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            Text("Hit the like button on each product page to save favorite ones.")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)

                        }
                    }
                    else{
                        VStack(spacing:15){
                            ForEach(sharedData.likedProducts){product in
                                HStack(spacing: 0){
                                    if showDeleteLiked{
                                        Button{
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                }

                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            Color("HomeBG")
                .ignoresSafeArea()
            )
        }
    }
    @ViewBuilder
    func CardView(product: Product) -> some View{
        HStack(spacing:15){
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8){
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                Text(product.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple"))
                Text("Type: \(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(15)
        )
    }
    
    func deleteProduct(product: Product){
        if let index = sharedData.likedProducts.firstIndex(where: {
            currentProduct in
            return product.id == currentProduct.id
        }){
            let _ = withAnimation{
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct Liked_Previews: PreviewProvider {
    static var previews: some View {
        Liked()
            .environmentObject(SharedDataModel())

    }
}
