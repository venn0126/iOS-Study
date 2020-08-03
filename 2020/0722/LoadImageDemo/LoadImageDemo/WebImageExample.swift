//
//  WebImageExample.swift
//  LoadImageDemo
//
//  Created by Augus on 2020/7/31.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageExample: View {
    let url: URL?
    
    
    var body: some View {
        WebImage(url: url)
            .placeholder{
                Color.gray
        }
        .onSuccess(perform: {_,_,_ in
            
            print("success")
            SDWebImageManager.shared.imageCache.clear(with: .all, completion: nil)
        })
            
            .onFailure(perform: {_ in
                print("fail")
            })
        .resizable()
        .scaledToFill()
        .frame(height: 600)
        
    }
}

