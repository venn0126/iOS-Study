//
//  DefaultsManager.swift
//  MengTestScb
//
//  Created by Augus Venn on 2023/12/12.
//

import Foundation
import UIKit


class DefaultsManager {
    
    var defaults = UserDefaults.standard
    
    static var shared: DefaultsManager {
        get {
            return DefaultsManager()
        }
    }
    
    // getter and setter
   var mengRootFlag: Bool {
        get {
            defaults.bool(forKey: "mengRootFlag")
        }
        set {
            defaults.set(newValue, forKey: "mengRootFlag")
        }
    }
    
    
    // test some params
    func isShowFavorite(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int, g: Int, h: Int) -> Bool {
        
        let temp = a + b + c + d + e + f + g + h
        if temp > 100 {
            return true
        } else {
            return false
        }
    }
    
    // instance method
    public func get(urlString: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        
        if(urlString.isEmpty) {
            completion(.failure(NSError(domain: "urlStringi is empty", code: -100001)))
            return
        }
        
        sleep(2)
        
        let img = UIImage(named: "activity_hot_icon_img")
        if let img = img, let data = img.pngData() {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "image is nil", code: -100002)))
        }
        
    }
    
    
    // class method
    class func isCallClsMethod(name: String) -> String {
        print("DefaultsManager isCallClsMethod")
        return "Hello" + name
    }
    
}
