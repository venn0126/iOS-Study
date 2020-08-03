//
//  NetworkAPI.swift
//  TestURLSession
//
//  Created by Augus on 2020/7/29.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import Foundation

class NetworkAPI {
    
    
    static func recommandPostList(completion: @escaping (Result<PostList,Error>) -> Void) {
        
        NetworkManger.shared.requestGet(path: "PostListData_recommend_1.json", params: nil) { result in
            switch result {
                
            case let .success(data):
                let parseResult: Result<PostList, Error> = self.parseData(data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
        }
    }
    
    static func hotPostList(completion: @escaping (Result<PostList,Error>) -> Void) {
        
        NetworkManger.shared.requestGet(path: "PostListData_hot_1.json", params: nil) { result in
            switch result {
                
            case let .success(data):
                let parseResult: Result<PostList, Error> = self.parseData(data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
        }
    }
    
    
    static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkAPIErrorDomain", code: -100, userInfo: [NSLocalizedDescriptionKey:"Can not parase data"])
            return .failure(error)
            
        }
        
        return .success(decodeData)
    }
    
}
