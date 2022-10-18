//
//  MoreProduct.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 30.12.2021.
//

import SwiftUI

struct MoreProduct: View {
    var body: some View {
        VStack{
            Text("More Products")
                .font(.custom(customFont, size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

struct MoreProduct_Previews: PreviewProvider {
    static var previews: some View {
        MoreProduct()
    }
}
