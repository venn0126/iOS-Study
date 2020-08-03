//
//  PostVIPBadge.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/22.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

struct PostVIPBadge: View {
    
    
    let vip: Bool
    
    var body: some View {
        Group {
            if vip {
                Text("V")
                    .bold()
                    .frame(width: 15,height: 15)
                    .font(.system(size: 11))
                    .foregroundColor(.yellow)
                    .background(Color.red)
                    .clipShape(Circle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 7.5)
                            .stroke(Color.white,lineWidth: 1)
                            .offset(x: 16,y: 16)
                        
                        
                )
            }
        }
    }
}

struct PostVIPBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVIPBadge(vip: true)
    }
}
