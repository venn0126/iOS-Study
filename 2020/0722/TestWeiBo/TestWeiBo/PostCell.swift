//
//  PostCell.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/22.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    var post: Post
    
    @State var presentComment: Bool = false
        
    var bindingPost: Post {
        
        userData.post(forId: post.id)!
    }
    
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        
        var post = bindingPost
       return VStack(alignment: .leading,spacing: 10) {
                 HStack(spacing: 5) {
             
                     // icon
                    post.avatarImage 
                         .resizable()
                         .scaledToFit()
                         .frame(width: 50,height: 50)
                         .clipShape(Circle())
                         .overlay(
                             PostVIPBadge(vip: post.vip)
                         )
                     
                     
                     // user name
                     VStack(alignment: .leading, spacing: 5) {
                         Text(post.name)
                             .font(Font.system(size: 16))
                             .foregroundColor(Color.init(red: 242 / 255, green: 99 / 255, blue: 4 / 255))
                             .lineLimit(1)
                         
                         Text(post.date).font(.system(size: 11))
                             .foregroundColor(.gray)
                         
                     }
                     
                     .padding(.leading, 10)
                     
                     if !post.isFollowed {
                         Spacer()
                        
                          Button(action: {
//                            print("i love u")
                            post.isFollowed = true
                            self.userData.updatePost(post)
                            
                          
                          }){
                              
                              Text("关注")
                                  .font(.system(size: 14))
                                  .foregroundColor(.orange)
                                  .frame(width: 50,height: 26)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 13)
                                          .stroke(Color.orange,lineWidth: 1)
                                      
                              )
                              
                          }
                     .buttonStyle(BorderlessButtonStyle())
                      }
                    
                 }
            
            
            Text(post.text)
                .font(.system(size: 17))
            
            if !post.images.isEmpty {
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)

            }
            
            Divider()
            
            
            //评论 and 点赞
            HStack(spacing: 0){
                
                Spacer()

                PostCellToolBarButton(image: "message", text: post.commentCountText, color: .black)
                {
                    print("click comment ")
                    
                    self.presentComment = true
                }
                    // modal present
                    .sheet(isPresented: $presentComment) {
                        CommentInputView(post: post).environmentObject(self.userData)

                        
                }
                
                Spacer()
                
                PostCellToolBarButton(image: post.isLiked ? "heart.fill" : "heart", text: post.likeCountText, color:post.isLiked ? .red : .black)
                {
//                    print("click liked ")
                    if self.post.isLiked {
                        
                        post.isLiked = false
                        post.likeCount -= 1
                     } else {
                       post.isLiked = true
                        post.likeCount += 1
                     }
                    
                    self.userData.updatePost(post)
                }
                
                Spacer()
                
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
            
            
           
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
    
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData.testData
        
        return PostCell(post: userData.remmendPostList.list[3]).environmentObject(userData)
    }
}
