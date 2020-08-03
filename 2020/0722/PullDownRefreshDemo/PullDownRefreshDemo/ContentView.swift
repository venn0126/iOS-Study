//
//  ContentView.swift
//  PullDownRefreshDemo
//
//  Created by Augus on 2020/7/31.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI
import BBSwiftUIKit

struct ContentView: View {
    
    @State var list: [Int] = (0..<50).map { $0 }
    @State var isRefreshing: Bool = false
    @State var isLoadingMore: Bool = false
    
    var body: some View {
        
        BBTableView(list) { i in
            Text("tian-\(i)")
                .padding()
                .background(Color.blue)
            
            
        }
        .bb_setupRefreshControl{ control in
            
            control.tintColor = .red
            control.attributedTitle = NSAttributedString(string: "飞速加载中...", attributes: [.foregroundColor:UIColor.green])
        }
        .bb_pullDownToRefresh(isRefreshing: $isRefreshing) {
            print("pullDownToRefresh")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // 下拉的时候重置数据，微博中就是获取新的数据
                self.list = (0..<50).map { $0 }
                
                self.isRefreshing  = false
            }
        }
        // 当底部间距小于等于 30就会触发
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            
   
            if self.isLoadingMore || self.list.count >= 100{
                return
            }
            
            self.isLoadingMore = true
            print("load more")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // 上滑的时候 增加数据
                
                let more = self.list.count..<self.list.count + 10
                
                self.list.append(contentsOf: more)
                self.isLoadingMore  = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
