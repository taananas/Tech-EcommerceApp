//
//  ContentView.swift
//  Tech Ecommerce
//
//  Created by Богдан Зыков on 29.12.2021.
//

import SwiftUI

struct ContentView: View {
   @AppStorage("log_status") var log_status: Bool = false
    var body: some View {

        Group{
            if log_status{
                MainPage()
            }
            else{
                OnBordingPage()
            }
        }
  }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
