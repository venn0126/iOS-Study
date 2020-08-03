//
//  CommentTextView.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/24.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    @Binding var text: String
    
    var beginEditingOnAppear: Bool
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        // 字体与view边框的距离
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate =  context.coordinator
        view.text = text
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {

//        print("update textview ")
        
        if beginEditingOnAppear,
            !context.coordinator.didBecomeFirstResponder,
            uiView.window != nil,
            !uiView.isFirstResponder
            
        {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }

    }
    

    class Coordinator: NSObject, UITextViewDelegate {
        
        let parent: CommentTextView
        // 第一次进入编辑状态
        var didBecomeFirstResponder: Bool = false
        init(_ view: CommentTextView) {
            parent = view
        }
        

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant(""),beginEditingOnAppear: true)
    }
}
