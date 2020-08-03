//
//  ContentView.swift
//  LoadImageDemo
//
//  Created by Augus on 2020/7/31.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI


private let url = URL(string: "https://cdn.discordapp.com/attachments/569722032137437191/677350898556600355/kobe.jpg")

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            List {
                
                
                NavigationLink(destination: SampleExample(url: url)){
                    Text("Sample Example")
                }
                
                NavigationLink(destination: WebImageExample(url: url)){
                    Text("WebImage Example")
                }
            }
        }.navigationBarTitle("Load Image")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
