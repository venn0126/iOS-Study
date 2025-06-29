//
//  ContentView.swift
//  GTSwiftUITest
//
//  Created by Augus Venn on 2024/1/9.
//

import SwiftUI

struct ContentView: View {
    
    @State private var value = 0
    @State private var value1 = 0

    
    
    var body: some View {
//        Greeting()
        /*
         
         */
        let _ = Self._printChanges()
        
        Text("* This is **bold** text, this is *italic* text, and this is ***bold, italic*** text.[click here](https://apple.com) ~~A strikethrough example~~`Monospaced works too`Visit Apple: [click here](https://apple.com)")

            .padding()
        
    }
}


struct ViewTreeTest: View {
    
    @State private var showText = true
    @State private var helloText: String? = "1"
    @State private var highlighted = true
    
    var body: some View {
        HStack {
            Image(systemName: "heart")
                .font(.title)
                .background(Color.red)
                .frame(width: 100)
            
            
            Text(helloText ?? "sohu")
                .font(.title2)
                .id(helloText == nil)
            //                    .applyIf(highlighted) { view in
            //                        view.background(.yellow)
            //                    }
                .applyIf() {
                    $0.background(.yellow)
                }
            
            //            Spacer()
            
        }
    }
        //        .frame(maxWidth: .infinity, alignment: .leading)

}

struct Greeting: View {
    
    @ViewBuilder var heart: some View {
        Image(systemName: "heart.fill")
        Text("My heart will go on")
    }
    
    @ViewBuilder var bye: some View {
        Text("on go will heart My")
        Image(systemName: "hand.wave")
    }
    
    var body: some View {
        
        let _ = Self._printChanges()
//        HStack {
//            heart
//                .border(.blue)
//            Spacer()
//            bye
//        }
        HStack {
            Group {
                Image(systemName: "heart.fill")
                Text("My heart will go on")
            }
            .background(Color.red)
//            .overlay(Color.red)
        }
    }
}


// MARK: Binding
struct GTCounter: View {
    
    // 0
    @Binding var value: Int
    
    // 1
    var value1: Int
    var setValue1: (Int) -> ()
    
    var body: some View {
        Button("增加:\(value1)") {
            setValue1(value1+1)
        }
    }
    
    
    // 1
//    var _value: Binding<Int>
//    var value: Int {
//        get {_value.wrappedValue}
//        set {_value.wrappedValue = newValue}
//    }
//    
//    init(value: Binding<Int>) {
//        self._value = value
//    }
    
//    var body: some View {
//        Button("增加:\(value)") {
//            value += 1
//        }
//    }
}

#Preview {
    ContentView()
}
