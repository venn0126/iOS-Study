//
//  PostImageCell.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/23.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI


private let kImageSpace: CGFloat = 6

struct PostImageCell: View {
    
    let images: [String]
    let width: CGFloat
    
    var body: some View {
        Group {
            if images.count == 1 {
                loadImageFromName(imageName: images[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: width,height:  width * 0.75)
                    .clipped()
            } else if images.count == 2 {
                PostImageCellRow(images: images, width: width)
            }else if images.count == 3 {
                PostImageCellRow(images: images, width: width)

            }else if images.count == 4 {
                
                VStack(spacing: kImageSpace) {
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...3]), width: width)
                }
                
                
            }else if images.count == 5 {
                VStack(spacing: 6) {
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...4]), width: width)
                }
            }else if images.count == 6 {
                VStack(spacing: kImageSpace) {
                   PostImageCellRow(images: Array(images[0...2]), width: width)
                   PostImageCellRow(images: Array(images[3...5]), width: width)
                }
            }
        }
    }
}


struct PostImageCellRow: View {
    let images: [String]
    let width: CGFloat
    
    var body: some View {
    
        HStack(spacing: kImageSpace){
            
            ForEach(images,id: \.self){ image in
                loadImageFromName(imageName: image)
                .resizable()
                .scaledToFill()
                    .frame(width:(self.width - kImageSpace * CGFloat(self.images.count)) / CGFloat(self.images.count),height: (self.width - kImageSpace * CGFloat(self.images.count)) / CGFloat(self.images.count))
                .clipped()
                
                
            }
        }
    }
}

struct PostImageCell_Previews: PreviewProvider {
    static var previews: some View {
                
        let images = UserData().remmendPostList.list[0].images
        let width = UIScreen.main.bounds.width - 30
        
       return Group{
            PostImageCell(images: Array(images[0...0]),width: width)
            PostImageCell(images: Array(images[0...1]),width: width)
            PostImageCell(images: Array(images[0...2]),width: width)
            PostImageCell(images: Array(images[0...3]),width: width)
            PostImageCell(images: Array(images[0...4]),width: width)
            PostImageCell(images: Array(images[0...5]),width: width)
        }
        .previewLayout(.fixed(width: width, height: 300))
    }
}
