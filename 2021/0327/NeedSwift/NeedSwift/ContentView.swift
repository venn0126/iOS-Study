//
//  ContentView.swift
//  NeedSwift
//
//  Created by Augus on 2021/3/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<50){item in
                NavigationLink(
                    destination: Text("Love Tian Forever"))
                {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.red)
                    VStack(alignment:.leading, spacing: 0) {
                        
                        Text("Ai Gao Tian")
                            .foregroundColor(.purple)
                            .font(.title)
                        Text("Augus")
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                        
                    }
                }
            }
            .navigationBarTitle("Love Tian")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
