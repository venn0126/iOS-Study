//
//  ContentView.swift
//  StandfordDemo0
//
//  Created by Augus on 2021/5/18.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = ["🚜","🚈","🚘","🚒","🛬","🚃","🚨","🚋","🚊","🛵","🦽","🦼","🏍","🛺","🚔","🚡","🚠","✈️","🛩","💺","🛰","🚀","🛸","🚁","🛶","⛵️","🚤","🛳","🗿","🗽","🏰","🏯","🌋","🏭","🎛","🏩","🏛","🕌","🏪","🚇","🚟","🚅","🏟","🎡","⛩"]
    @State var emojiCount = 4
    
    var body: some View {
        
        VStack {
            // 滑动视图
            ScrollView {
                // 网格 & 横屏 竖屏的摆放格局
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80,maximum: 500))]) {
                    ForEach(emojis[0..<emojiCount],id: \.self) {emoji in
                        
                        CardView(content: emoji)
                            // 宽/高 比例 以及填充方式
                            .aspectRatio(2/3,contentMode: .fit)
                    }
                }
            }.foregroundColor(.red)
            //
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }.font(.largeTitle)
        }
        
        .padding()
            
    }
    
    
    /// minus button view
    var remove: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    
    /// plus button view
    var add: some View {
        
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
    
    
}




/// A  card view struct
struct CardView: View {
   
    
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack
        {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill()
                    .foregroundColor(.white)
                // stroke(lineWidth：12) 会被srcoll的边缘切掉
                shape.strokeBorder(lineWidth: 2, antialiased: true)
                    .foregroundColor(.orange)
                Text(content).font(.largeTitle)
                
            } else {
                shape.fill()
                    .foregroundColor(.red)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            
        ContentView()
            .preferredColorScheme(.dark)
    }
}
