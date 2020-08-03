//
//  CommentInputView.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/24.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    
    
    
    let post: Post
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData: UserData
    
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    @State private var text: String = ""
    
    @State private var showEmptyTextHUD: Bool = true
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            CommentTextView(text: $text,beginEditingOnAppear: true)
            
            HStack(spacing: 0){
                
                // cancel
                Button(action: {
//                    print("cancel comment post")
                    self.presentationMode       .wrappedValue.dismiss()
                }){
                    Text("取消").padding()
                }
                
                Spacer()
                // send
                
                Button(action: {
                    
                    // 过滤空格和tab
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        self.showEmptyTextHUD = true
                        
                        // 1.5s 消失
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.showEmptyTextHUD = false

                        }
                        
                        return
                    }
                    
                    
                    var post = self.post
                    post.commentCount += 1
                    
                    self.userData.updatePost(post)
                    self.presentationMode.wrappedValue.dismiss()
                    
                    
                    print(self.text)
                }){
                    Text("发送").padding()
                }
            }
            .font(.system(size: 18))
            .foregroundColor(.black)
        }
            
        .overlay(
            Text("评论不能为空")
                .scaleEffect(showEmptyTextHUD ? 1 : 0.5)
                .animation(.spring(dampingFraction: 0.5))
                .opacity(showEmptyTextHUD ? 1 : 0)
                .animation(.easeInOut)
            )
            
        .padding(.bottom,keyboardResponder.keyboardHeight)
        .edgesIgnoringSafeArea(keyboardResponder.keyboardShow ? .bottom : [])
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: UserData().remmendPostList.list[0])
    }
}
