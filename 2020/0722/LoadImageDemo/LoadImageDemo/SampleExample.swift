//
//  SampleExample.swift
//  LoadImageDemo
//
//  Created by Augus on 2020/7/31.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

struct SampleExample: View {
    
    
    // 图片的url
    let url: URL?
    
    // 图片data数据
    @State private var data: Data?
    private var image: UIImage? {
        if let data = self.data {
            return UIImage(data: data)
        }
        return nil
    }
    
    
    var body: some View {
        let image = self.image
        return Group {
            if image != nil {
                Image(uiImage: image!)
                .resizable()
                .scaledToFill()
                
            } else {
                Color.green
            }
            // 图片显示的时候 加载图片
        }
        .frame(height: 600)
        .clipped()
        .onAppear{
            if let url = self.url,self.data == nil {
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.data = data
                    }
                }
            }
        }
    }
}


