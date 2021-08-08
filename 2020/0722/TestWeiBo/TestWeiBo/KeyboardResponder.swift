//
//  KeyboardResponder.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/24.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    
    
    @Published var keyboardHeight: CGFloat = 0
    var keyboardShow: Bool {
        keyboardHeight > 0
    }
    
    init() {
        
        // 键盘弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        
        // 键盘退出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    // iOS 9之前需要移除监听对象
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else {
            
            return
        }
        
        
        keyboardHeight = frame.height
        
        
        
    }
    
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        keyboardHeight = 0
        
    }

}


