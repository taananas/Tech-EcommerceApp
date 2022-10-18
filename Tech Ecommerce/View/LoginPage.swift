//
//  LoginPage.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 29.12.2021.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        VStack{
            Text(loginData.registeredUser ? "Welcome" : "Welcome\nback")
                .font(.custom(customFont, size: 60).bold())
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                    ZStack{
                        LinearGradient(colors: [
                            Color("LoginCircle"),
                            Color("LoginCircle").opacity(0.8),
                            Color("Purple")
                        ],startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading, 60)
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    Text(loginData.registeredUser ? "Sign Up" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    customTextField(icon: "envelope", title: "Email", hint: "Enter your email", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    customTextField(icon: "lock", title: "Password", hint: "Enter your password", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                    
                    if loginData.registeredUser {
                        
                        customTextField(icon: "lock", title: "Repeat Password", hint: "Repeat your password", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    if !loginData.registeredUser {
                        
                        Button{
                            loginData.ForgotPassword()
                        } label: {
                            Text("Forgot password?")
                                .font(.custom(customFont, size: 14).bold())
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Purple"))
                        }
                        .padding(.top,8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Button{
                        if loginData.registeredUser{
                            loginData.Register()
                        }else {
                            loginData.Login()
                        }
                    } label: {
                        Text(loginData.registeredUser ? "Sign Up" : "Login")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top,25)
                    .padding(.horizontal)
                    
                    Button{
                        withAnimation(.easeIn){
                            loginData.registeredUser.toggle()
                        }
                    } label: {
                        Text(loginData.registeredUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 16).bold())
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        .onChange(of: loginData.registeredUser){ newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    @ViewBuilder
    func customTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View{
        VStack(alignment: .leading, spacing: 12){
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
                    .opacity(0.8)
            } icon: {
                Image(systemName: icon)
                    .opacity(0.8)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else{
                TextField(hint, text: value)
                    .padding(.top, 2)
            }

            Divider()
                .background(Color.black.opacity(0.4))
        }
        .overlay(
            Group{
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("Purple"))
                    })
                    .offset(y: 8)
                }
            }
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
