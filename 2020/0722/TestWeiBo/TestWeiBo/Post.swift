//
//  Post.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/22.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI


// 微博数组
struct PostList: Codable {
    var list: [Post]
}


//  data model 微博数据模型
struct Post: Codable, Identifiable {
    
    var id: Int //weibo id
    let avatar: String // 头像，图片名称
    let vip: Bool // 是否是vip
    let name: String // 微博昵称
    let date: String // 发微博日期
    var isFollowed: Bool //是否关注作者
    
    let text: String // weibo 文本内容
    let images: [String] // weibo包含图片数组
    var commentCount: Int // 评论数
    var likeCount: Int // 点赞数
    var isLiked: Bool //是否为这个微博点赞
    
  
}

extension Post: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}


extension Post {
    
    var avatarImage: WebImage {
        loadImageFromName(imageName: avatar)
    }
    
    // 计算属性 只读的
    var commentCountText: String {
        if commentCount <= 0 {return "评论"}
        if commentCount < 1000 {return "\(commentCount)"}
        return String(format: "%.1fk", Double(commentCount) / 1000)
    }
    
    var likeCountText: String {
        
        if likeCount <= 0 {return "点赞"}
        if likeCount < 1000 {return "\(likeCount)"}
        return String(format: "%.1fk", Double(likeCount) / 1000)
    }
}

//let postList = loadPostDataModel(fileName: "PostListData_recommend_1.json")


//let postList =


// 解析本地json文件
func loadPostDataModel( fileName: String) -> PostList {
    
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("can not find \(fileName) in main bundle")
    
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("can not load \(url)")
    }
    
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("can not decode post list json data ")
    }
    
    return list
    
}

// from image to image

func loadImageFromName( imageName: String) -> WebImage {
    
    return WebImage(url: URL(string: NetwrokAPIBaseURL + imageName)).placeholder{ Color.gray}
}
