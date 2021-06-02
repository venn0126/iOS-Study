//
//  SwiftUIDog.swift
//  DDDemo
//
//  Created by Augus on 2021/5/19.
//

import SwiftUI

struct SwiftUIDog: View {
    var name = "Augus"
    var emojis = ["🚜","🚈","🚘","🚒","🛬","🚃","🚨","🚋","🚊","🛵","🦽","🦼","🏍","🛺","🚔","🚡","🚠","✈️","🛩","💺","🛰","🚀","🛸","🚁","🛶","⛵️","🚤","🛳","🗿","🗽","🏰","🏯","🌋","🏭","🎛","🏩","🏛","🕌","🏪","🚇","🚟","🚅","🏟","🎡","⛩"]
    
    @State var emojiCount = 4
    
    var body: some View {
        
    
        VStack {
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 300))]) {
                    ForEach(emojis[0..<emojiCount],id: \.self){emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
      
            HStack {
                remove
                Spacer()
                add
                
            }
        }
        .font(.largeTitle)
        .padding()
    }
    
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1;
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
            
//            let two = TwoController()
            
            
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
}


struct DogView: View {
    
    var isDog: Bool = true
    
    var body: some View {
        
        // 可以返回不同类型的控件
        if isDog {
            
            Text("dog")
        } else {
            Button(action: {
                
            }, label: {
                Image(systemName: "ladybug")
            })
        }
    }

    var legs: some View {
//        @State var isDog: Bool = true

//        VStack(alignment: .center, spacing: nil, content: {
//            Text("hello")
//            Text("world")
////            var isDog = true
//            if true {
//                Text("dog")
////                isDog = false
//            } else {
//                Text("cat")
//            }
//        })
        
//        var dataArray = ["1","2","3","4"]
//        List(, id: \.self) { content in
            
            Text("gao")
            
//        }
        
        
    }
}

struct CardView: View {
    @State var isFaceUp = true
    @State var content: String
    
    var body: some View {
        
        ZStack {
            let shape =  RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3, antialiased: true).foregroundColor(.orange)
                Text(content)
            } else {
                shape.foregroundColor(.red)
            }
            
        }.onTapGesture {
            withAnimation(.spring()) {
                
                isFaceUp = !isFaceUp
            }
        }
//        它定义了一个可以响应目标 Publisher 的任意的 View，一旦订阅的 Publisher 发出新的事件时，onReceive 就将被调用
//        .onReceive(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Publisher@*/NotificationCenter.default.publisher(for: .NSCalendarDayChanged)/*@END_MENU_TOKEN@*/, perform: { _ in
//
//        })
//        .scaleEffect()
//        .animation(.spring())
//        .rotationEffect(.degrees(0))
        

    }
}






struct SwiftUIDog_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIDog()
            .preferredColorScheme(.light)
        SwiftUIDog()
            .preferredColorScheme(.dark)
    }
}
