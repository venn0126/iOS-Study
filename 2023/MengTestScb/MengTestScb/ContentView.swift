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
//        NavigationView {
//            VStack {
//                
//                TextField(
//                    MengStrings.username,
//                    text: $username
//                ).padding().onAppear() {
//                    self.username = ""
//                }
//                
//                SecureField(
//                    MengStrings.password,
//                    text: $password
//                ).padding().onAppear() {
//                    self.password = ""
//                }
//                
//                Button(action: {
//                    if username != "" && password != "" {
//                        isActive = true
//                    } else {
//                        isShowAlert = true
//                    }
//                }, label: {
//                    Text(MengStrings.login)
//                    if isActive {
//                        NavigationLink("", destination:  MengMainPageView(), isActive: $isActive)
//                    }
//                })
//                if isShowAlert {
//                    Text(MengStrings.logInValidation).padding(20)
//                }
//            }
//        }
        
        MengTestView()
    }
}

struct MengTestView: View {
    var body: some View {
        
        
        VStack(spacing: 20) {
            
            if DefaultsManager.shared.mengRootFlag {
                Text("it is rootFlag")
                    .font(.system(size: 30, weight: .medium))
            } else {
                Text("it not rootflag")
                    .font(.system(size: 20, weight: .bold))
            }
            
            
            if DefaultsManager.shared.isShowFavorite(a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8) {
                Image(systemName: "heart")
                    
            } else {
                Image(systemName: "heart.fill")
            }
            
            Text(DefaultsManager.isCallClsMethod(name: "Tian"))
                .font(.system(.title))
                .bold()
            
            let duck = GTDuck(duckType: "lightGray", name: "tian")
            Text(duck.isDuckAtHitb(duckName: "augus") ? "augus" : "Augus")
                .font(.system(.title2))
                .foregroundColor(.red)
            
        }
        .onAppear {
            testData(urlStr: "www.baidu.com")
        }
        
    }
    
    
    func testData(urlStr: String) -> Void {
        DefaultsManager.shared.get(urlString: urlStr) { result in
            switch result {
            case .success(let data):
                let _ = UIImage(data: data)
            case .failure(let error):
                print("get url error \(error)")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
