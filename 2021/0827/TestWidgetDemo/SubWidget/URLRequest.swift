//
//  URLRequest.swift
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

import Foundation


enum URLMethod {
    case post
    case get
}

struct URLRequest {
    
    static func method(completion: @escaping (Result<Poetry, Error>) -> Void) {
        let url = URL(string: "https://v2.alapi.cn/api/shici?type=shuqing&token=ZIppISTEaROwXivQ")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//                completion(.failure(error!))
                return
            }
            
            let poetry = poetryFromJson(fromData: data!)
            completion(.success(poetry!))
            
            
        }
        task.resume()
    }
    
    static func poetryFromJson(fromData: Data) -> Poetry? {
        let json = try! JSONSerialization.jsonObject(with: fromData, options: []) as! [String : Any]
        guard let data = json["data"] as? [String : Any] else {
            // error
            return nil
        }
        
        let content = data["content"] as! String
        let origin = data["origin"] as! String
        let author = data["author"] as! String
        return Poetry(content: content, origin: origin, author: author)
    }
    
    
}
