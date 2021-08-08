//
//  HTTPTool.swift
//  SwiftDataStructure
//
//  Created by Augus on 2021/6/27.
//

import Foundation


enum HTTPMethod {
    case GET
    case POST
}

protocol Request {
    
    var host: String { get }
    var path: String { get }
    
    var method: HTTPMethod { get }
    var parameter: [String : Any] { get }
    
    associatedtype Response
    
//    func parse(data: Data) -> Response?
    
}

//extension Request {
//
//    func send(handler: @escaping (Response?) -> Void) {
//
////        print("path is \(host.appending(path))")
//        let url = URL(string: "https://api.androidhive.info/volley/person_object.json")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "post"
//
//        let task = URLSession.shared.dataTask(with: request) {
//            data,_,error in
//            // 处理结果
//            if let data = data,let res = parse(data: data) {
//                DispatchQueue.main.async {
//                    handler(res)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    handler(nil)
//                }
//            }
//        }
//
//        task.resume()
//    }
//}

struct UserRequest: Request {
    
    // talk is cheap.show me the code
    // api https://api.androidhive.info/volley/person_object.json
    /**
     "name" : "Ravi Tamada",
         "email" : "ravi8x@gmail.com",
         "phone" : {
             "home" : "08947 000000",
             "mobile" : "9999999999"
         }
     */
    
    let host = "https://api.androidhive.info"
    var path: String {
        return "/volley/person_object.json"
    }
    
    let method: HTTPMethod = .GET
    let parameter: [String : Any] = [:]
    
    typealias Response = PlaceUser
    
//    func parse(data: Data) -> PlaceUser? {
//        return PlaceUser(data: data)
//    }
    
}


struct PlaceUser {
    let name: String
    let email: String
    let phone: [String]
    
    init?(data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        guard let name = obj["name"] as? String else {
            return nil
        }
        
        guard let email = obj["email"] as? String else {
            return nil
        }
        
        guard let phone = obj["phone"] as? [String] else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.phone = phone
        
    }
}

extension PlaceUser: Decodable {
    static func parse(data: Data) -> PlaceUser? {
        return PlaceUser(data: data)
    }
}


protocol Client {
    // <T: Request> 泛型
    func send<T: Request>(_ r: T,handler: @escaping (T.Response?) -> Void)
    
    // host 移动到client中
    var host: String { get }
    
}

struct URLSessionClient: Client {
    let host = "https://api.androidhive.info"
    
    func send<T>(_ r: T, handler: @escaping (T.Response?) -> Void) where T : Request {
        
        let url = URL(string: host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = URLSession.shared.dataTask(with: request) {
            data,_,error in
//            // 处理结果
            
//            if let data = data,let res = r.parse(data:data) {
//            if let data = data,let res = T.Response. {
//                DispatchQueue.main.async {
//                    handler(res)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    handler(nil)
//                }
//            }
        }
        
        task.resume()
    }
    

}

protocol Decodable {
    static func parse(data: Data) ->Self?
    
}


/// Test

struct LocalFileClient: Client {
    
    let host: String = "local path"
    
    func send<T>(_ r: T, handler: @escaping (T.Response?) -> Void) where T : Request {
        
        switch r.path {
        case "/user/augus":
            
            guard let fileURL = Bundle.main.url(forResource: "/user/augus", withExtension: "txt") else {
                fatalError()
            }
            
            guard let data = try? Data(contentsOf: fileURL) else {
                fatalError()
            }
            
            print(data)
//            handler(T.Response.parse(data:data))
            
            
        default:
            fatalError("unknow error")

            
        }
    }
}


func testUserClient()  {
//    let client = LocalFileClient()
//    client.send(UserRequest()) { (user) in
//        XCTAssertNotNil(user)
//        XCTAssertEqual(user!.name ,"augus")
//    }
}



