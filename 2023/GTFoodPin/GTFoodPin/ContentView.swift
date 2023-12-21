//
//  ContentView.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2023/12/21.
//

import SwiftUI




struct ContentView: View {
    @State var isShowOverlay: Bool = false

    var body: some View {
        
        SNClickSimulateView {
            ItemView()
        }

    }
    
}


struct SNClickSimulateView<Content: View>: View {
    
    let content: Content
    @State var showOverlay: Bool = false
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(.white)
            .onTapGesture {
                print("onTapGesture")
                withAnimation(Animation.linear(duration: 0.1).delay(0.1)) {
                    self.showOverlay = false
                }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        print("TapGesture onEnded")
                        self.showOverlay = true
                    }
            )
            .opacity(self.showOverlay ? 0.3 : 1)
    }
    
}


struct ItemView: View {
    var body: some View {
        
        HStack(alignment: .center) {
            Text("外国人对亚洲人")
                .frame(width: 150.0)
                .font(.title)
//                .foregroundColor(.black)
                .lineLimit(1)
            
            Image("activity_hot_icon_img")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
        }
    }
}



#Preview {
    ContentView()
}
