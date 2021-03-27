//
//  HomeNavgationBar.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/23.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI


private let kLabelWidth: CGFloat = 60
private let kButtonHeight: CGFloat = 24


struct HomeNavgationBar: View {
    
    
   @Binding var leftPercent: CGFloat //0 left,1 right
    
    
    var body: some View {
        
        HStack(alignment: .top,spacing: 0) {
            
            // camera button
            Button(action: {
               print("click camera button")
            }){
                Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                    .frame(width: kButtonHeight,height: kButtonHeight)
                    .padding(.horizontal,15)
                    .padding(.top,5)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            
            // tuijian and hot
            VStack(spacing: 3){
                   HStack(spacing: 0) {
                      Text("推荐")
                          .bold()
                          .frame(width: kLabelWidth,height: kButtonHeight)
                          .padding(.top,5)
                          .opacity(Double(1 - leftPercent * 0.5))
                          .onTapGesture {
                            withAnimation {
                                self.leftPercent = 0
                            }
                         
                          }
                      
                      Spacer()
                      
                      Text("热门")
                      .bold()
                      .frame(width: kLabelWidth,height: kButtonHeight)
                      .padding(.top,5)
                        .opacity(Double(0.5 + leftPercent * 0.5))
                      .onTapGesture {
                            withAnimation {
                                self.leftPercent = 1
                        }
                     }
                              
                    }
                   .font(.system(size: 20))
                       
                   // 几何阅读器
                   GeometryReader { geometry in
                       // 0->left 1->right
                       RoundedRectangle(cornerRadius: 2)
                               .foregroundColor(.orange)
                               .frame(width: 30,height: 4)
                        .offset(x: self.leftPercent == 0 ? 15 : geometry.size.width - 45)
                    
                    /*
                     offset(x: geometry.size.width * (self.leftPercent - 0.5) + kLabelWidth * CGFloat(0.5 - self.leftPercent))
                     */
                       }
                   
                   .frame(height: 30)
                   }
                   
                   
               // set all frame width
                   .frame(width: UIScreen.main.bounds.width * 0.5)
            
            
            Spacer()
            
            Button(action: {
               print("click plus button")
            }){
                Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                    .frame(width: kButtonHeight,height: kButtonHeight)
                    .padding(.horizontal,15)
                    .padding(.top,5)
                    .foregroundColor(.orange)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct HomeNavgationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavgationBar(leftPercent: .constant(0))
    }
}
