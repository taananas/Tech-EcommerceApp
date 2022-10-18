//
//  LoginPageModel.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 29.12.2021.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    @Published var registeredUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    
    @AppStorage("log_status") var log_status: Bool = false

    
    
    func Login(){
        withAnimation{
            log_status = true
        }
    }
    func Register(){
        withAnimation{
            log_status = true
        }
    }
    func ForgotPassword(){
//        
    }
}
