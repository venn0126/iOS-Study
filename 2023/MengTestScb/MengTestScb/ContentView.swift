//
//  ContentView.swift
//  MengTestScb
//
//  Created by Augus on 2023/9/14.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isActive = false
    @State private var isShowAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField(
                    MengStrings.username,
                    text: $username
                ).padding().onAppear() {
                    self.username = ""
                }
                
                SecureField(
                    MengStrings.password,
                    text: $password
                ).padding().onAppear() {
                    self.password = ""
                }
                
                Button(action: {
                    if username != "" && password != "" {
                        isActive = true
                    } else {
                        isShowAlert = true
                    }
                }, label: {
                    Text(MengStrings.login)
                    if isActive {
                        NavigationLink("", destination:  MengMainPageView(), isActive: $isActive)
                    }
                })
                if isShowAlert {
                    Text(MengStrings.logInValidation).padding(20)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}