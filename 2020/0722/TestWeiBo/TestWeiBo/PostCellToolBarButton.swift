//
//  PostCellToolBarButton.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/22.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

struct PostCellToolBarButton: View {
    
    let image: String //图片名称
    let text: String //点赞还是评论
    let color: Color
    let action: () -> Void // closure 闭包
    
    var body: some View {
        Button(action: action){
            HStack(spacing: 5){
                Image(systemName: image)
                .resizable()
                .scaledToFit()
                    .frame(width: 18,height: 18)
                Text(text)
                    .font(.system(size: 15))
                
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())

    }
}

struct PostCellToolBarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolBarButton(image: "heart", text: "评论", color: .red) {
            print("点赞")
        }
    }
}
