//
//  SwiftDogDetail.swift
//  DDDemo
//
//  Created by Augus on 2021/5/19.
//

import Foundation
import SwiftUI

@objc
class SwiftDogDetail: NSObject {
    
    @objc func makePlayDogName(_ name: String) -> UIViewController {
        
        var details = SwiftUIDog()
        details.name = name
        return UIHostingController(rootView: details)
    }
}



struct Dog {
    
//    let apiRequest = 
  
}

extension NotificationCenter {
    
//    struct Publisher: Combine.Publisher {
//        typealias Output = Notification
//        typealias Failure = Never
//        init(center: NotificationCenter,name: Notification.Name,object: Any? = nil) {
//
//        }
//    }
}
