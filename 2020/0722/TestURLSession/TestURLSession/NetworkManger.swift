//
//  NetworkManger.swift
//  TestURLSession
//
//  Created by Augus on 2020/7/28.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI
import Alamofire



typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void


let NetwrokAPIBaseURL = "https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/"

class NetworkManger {
    
    
    // 单例
    static let shared = NetworkManger()

    
    // 共同的Headers
    var commonHeader: HTTPHeaders  {
        ["user_name":"123",
         "user_password":"459"]
        
    }
    
    // 防止外部调用
    private init() {}

    
    // 外部调用这个函数 返回值可以忽略
    @discardableResult
    func requestGet(path: String, params: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetwrokAPIBaseURL + path,parameters: params,
                   headers: commonHeader,
                   requestModifier: {$0.timeoutInterval = 15})
            .responseData { response in
                switch response.result {
                    
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
        }
    }
    
    
    @discardableResult
    func requestPost(path: String, params: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetwrokAPIBaseURL + path,
                   method: .post,
                   parameters:params,
                   encoding: JSONEncoding.prettyPrinted,headers: commonHeader,
                   requestModifier: { $0.timeoutInterval = 15})
            .responseData { response in
                
                switch response.result {
                    
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
    
        }
    }
    
    
    private func handleError(_ error: AFError) -> NetworkRequestResult {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost  {
                
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有问题奥～"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
    
}
