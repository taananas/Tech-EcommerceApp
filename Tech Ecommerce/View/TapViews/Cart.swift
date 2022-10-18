//
//  Cart.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 01.01.2022.
//

import SwiftUI

struct Cart: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteLiked: Bool = false
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        HStack{
                        Text("Basket")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        
                        if sharedData.cartProducts.isEmpty{
                            Group{
                                Image("EmptyCart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                    .padding(.top,35)
                                Text("No Items added")
                                    .font(.custom(customFont, size: 25))
                                    .fontWeight(.semibold)
                                Text("Hit the add button to save into basket")
                                    .font(.custom(customFont, size: 18))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)

                            }
                        }
                        else{
                            VStack(spacing:15){
                                ForEach($sharedData.cartProducts){$product in
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
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top,25)
                            .padding(.horizontal)
                        }
                    }

                    .padding()
                }
                if !sharedData.cartProducts.isEmpty{
                    Group{
                        HStack{
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(Color("Purple"))
                        }
                        
                        Button{
                            
                        } label: {
                            Text("Checkout")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color("Purple"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal, 25)

                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            Color("HomeBG")
                .ignoresSafeArea()
            )
        }
    }

    func deleteProduct(product: Product){
        if let index = sharedData.cartProducts.firstIndex(where: {
            currentProduct in
            return product.id == currentProduct.id
        }){
            let _ = withAnimation{
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
            .environmentObject(SharedDataModel())
    }
}

struct CardView: View{
    
    @Binding var product: Product
    
    var body: some View{
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
                HStack(spacing: 10){
                    Text("Quantity: ")
                        .font(.custom(customFont, size: 14))
                        .foregroundColor(.gray)
                    
                    Button{
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    }label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.cyan)
                            .cornerRadius(4)
                    }
                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button{
                        product.quantity += 1
                    }label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.cyan)
                            .cornerRadius(4)
                    }
                }
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
}
