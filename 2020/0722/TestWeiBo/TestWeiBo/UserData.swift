//
//  UserData.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/23.
//  Copyright © 2020 Fosafer. All rights reserved.
//


import Foundation
import Combine

class UserData: ObservableObject {
   
    @Published var remmendPostList: PostList = loadPostDataModel(fileName: "PostListData_recommend_1.json")
    @Published var hotPostList: PostList = loadPostDataModel(fileName: "PostListData_hot_1.json")
    @Published var isRefreshing: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var loadingError: Error?
    @Published var reloadData: Bool = false
    
    private var remmentPostDic: [Int: Int] = [:]
    private var hostPostDic: [Int: Int] = [:]
    
    
    init() {
        for i in 0..<remmendPostList.list.count {
            let post = remmendPostList.list[i]
            remmentPostDic[post.id] = i
            
        }
        
        for i in 0..<hotPostList.list.count {
            let post = hotPostList.list[i]
            hostPostDic[post.id] = i
            
        }
    }
}


extension UserData {
    
    
    var showLoadingError: Bool {loadingError != nil}
    var loadingErrorText: String {loadingError?.localizedDescription ?? ""}
    
    func postList(for cateory: PostListCateory) -> PostList {
        switch cateory {
            case .recommend: return remmendPostList
            case .hot: return hotPostList

        }
    }
    
    // pull refresh
    func refreshPostList(for catetory: PostListCateory) {
        
        
        let completion: (Result<PostList,Error>) -> Void = { (result) in
            switch result {
            case let .success(list): self.handleRefreshList(list, for: catetory)
            case let .failure(error): self.handleError(error)
            }
            self.isRefreshing = false
            
        }
        
        switch catetory {
        case .recommend:NetworkAPI.recommandPostList(completion: completion)
        case .hot:NetworkAPI.hotPostList(completion: completion)
        }
        
        reloadData = true 
    }
    
    private func handleRefreshList(_ list: PostList,for category: PostListCateory) {
        
        var tempList: [Post] = []
        var tempDict: [Int : Int] = [:]
        for (index,post) in list.list.enumerated() {
            //直接进入下次循环，说明重复了
            if tempDict[post.id] != nil { continue}
            tempList.append(post)
            tempDict[post.id] = index
            // update local data from server
//            updatePost(post)
        }
        
        switch category {
        case .recommend:
            remmendPostList.list = tempList
            remmentPostDic = tempDict
        case .hot:
            hotPostList.list = tempList
            hostPostDic = tempDict
        
        }
        
    }
    
    
    private func handleError(_ error: Error) {
        loadingError = error
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.loadingError = nil
        }
    }
    
    
    // load more
    func loadingMorePostList(for cateory: PostListCateory) {
        
        if isRefreshing  || postList(for: cateory).list.count > 10 { return }
        
        let completion: (Result<PostList,Error>) -> Void = { (result) in
            switch result {
            case let .success(list): self.handleLoadingMoreList(list, for: cateory)
            case let .failure(error): self.handleError(error)
            }
            self.isLoadingMore = false
        }
        
        switch cateory {
            case .recommend:NetworkAPI.hotPostList(completion: completion)
            case .hot:NetworkAPI.recommandPostList(completion: completion)
        }
    }
    
    private func handleLoadingMoreList(_ list: PostList,for cateory: PostListCateory) {
        
        switch cateory {
        case .recommend:
            
            for post in list.list {
//                updatePost(post)
                if remmentPostDic[post.id] != nil {continue}
                remmendPostList.list.append(post)
                remmentPostDic[post.id] = remmendPostList.list.count - 1
                
            }
            
            
        case .hot:
            for post in list.list {
                if hostPostDic[post.id] != nil {continue}
                hotPostList.list.append(post)
                hostPostDic[post.id] = hotPostList.list.count - 1
                
            }
        }
    }
    
    
    func post(forId id:Int) -> Post? {
        if let index = remmentPostDic[id] {
            return remmendPostList.list[index]
        }
        
        if let index = hostPostDic[id] {
            return hotPostList.list[index]
        }
        
        return nil
        
    }
    
    
    func updatePost(_ post: Post) {
        if let index = remmentPostDic[post.id] {
            remmendPostList.list[index] = post
        }
        
        if let index = hostPostDic[post.id] {
            hotPostList.list[index] = post
        }
    }
    
}

enum PostListCateory {
    case recommend, hot
    
}


