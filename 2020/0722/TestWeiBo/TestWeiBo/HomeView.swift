//
//  HomeView.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/23.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    
    
    @State var leftPercent: CGFloat = 0
    
    // 构造方法
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        
        // add nav bar for home view
            NavigationView {
                
                
                GeometryReader { geometry in
                    
                    HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height), leftPercent: self.$leftPercent) {
                        
                        HStack(spacing: 0) {
                         PostListView(cateory: .recommend)
                            .frame(width: geometry.size.width)
                         PostListView(cateory: .hot)
                             .frame(width: geometry.size.width)
                                
                        }
                        
                    }
                    .edgesIgnoringSafeArea(.bottom)

                }
                
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarItems(trailing: HomeNavgationBar(leftPercent: $leftPercent))
                .navigationBarTitle("tian",displayMode: .inline)
            }
                
            // 适配iPad
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData.testData)
    }
}
