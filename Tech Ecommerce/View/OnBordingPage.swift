//
//  OnBordingPage.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 29.12.2021.
//

import SwiftUI

let customFont = "Raleway-Regular"


struct OnBordingPage: View {
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 60))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("OnBoard")
                .resizable()
                .aspectRatio(contentMode: .fit)
//            background(
//                LinearGradient(colors: [Color("Purple"), Color.blue], startPoint: .top, endPoint: .bottom)
//            )
//            add gradient image bottom
            Button {
                withAnimation {
                    showLoginPage = true
                }
                
            } label: {
                Text("Get started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
            }
            .padding(.horizontal, 30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("Purple")
        )
        .overlay(
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBordingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBordingPage()
    }
}

extension View {
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}
