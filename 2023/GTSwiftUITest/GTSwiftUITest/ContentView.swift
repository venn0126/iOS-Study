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
        VStack {
     
            GTCounter(value: $value, value1: value1, setValue1: {value1 = $0})
                .foregroundColor(.red)
                .font(.system(size: 30))
        }
        .padding()
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
