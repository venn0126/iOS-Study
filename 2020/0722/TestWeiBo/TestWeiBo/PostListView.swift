//
//  PostListView.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/22.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI
import BBSwiftUIKit

struct PostListView: View {
    
    let cateory: PostListCateory
    @EnvironmentObject var userData: UserData
    
    var body: some View {
            
            BBTableView(userData.postList(for: cateory).list) {post in
                NavigationLink(destination: PostDetailView(post: post)) {
                    PostCell(post: post)
                    
                }
            .buttonStyle(OriginalButtonStyle())
                
            }
            .bb_setupRefreshControl { control in
                
                control.attributedTitle = NSAttributedString(string: "加载中...")
            }
            .bb_pullDownToRefresh(isRefreshing: $userData.isRefreshing) {
                                
                self.userData.refreshPostList(for: self.cateory)
            }
            .bb_pullUpToLoadMore(bottomSpace: 30) {
                
                self.userData.loadingMorePostList(for: self.cateory)
            }
       
            .bb_reloadData($userData.reloadData)
                
            .onAppear {
                self.userData.loadPostListIfNeed(for: self.cateory)
            }
            .overlay(
                Text(userData.loadingErrorText)
                    .bold()
                    .frame(width: 200)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .opacity(0.8)
                )
                    .animation(nil)
                    .scaleEffect(userData.showLoadingError ? 1 : 0.5)
                    .animation(.spring(dampingFraction: 0.5))
                    .opacity(userData.showLoadingError ? 1 : 0)
                    .animation(.easeInOut)
        )
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            PostListView(cateory: .recommend)
                .navigationBarTitle("Tian")
                // 此隐藏只有设置了title才会起作用
                .navigationBarHidden(true)
        }
        .environmentObject(UserData.testData)
    }
}
