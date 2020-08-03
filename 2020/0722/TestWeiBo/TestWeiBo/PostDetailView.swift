//
//  PostDetailView.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/23.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI
import BBSwiftUIKit

struct PostDetailView: View {
    
    
    // weibo 数据模型
    let post: Post
    
    var body: some View {
        
        
        BBTableView(0...10) { i in
            
            if i == 0 {
                PostCell(post: self.post)
                
            } else {
                
                HStack {
                    Text("评论\(i)").padding()
                    Spacer()
                }

            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("详情", displayMode: .inline)
      
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData.testData
        
        return  PostDetailView(post: userData.remmendPostList.list[0]).environmentObject(userData)
    }
}
