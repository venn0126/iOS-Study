//
//  HScrollViewController.swift
//  TestWeiBo
//
//  Created by Augus on 2020/7/23.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI



struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    let pageWidth: CGFloat
    let contentSize: CGSize
    let content: Content
    @Binding var leftPercent: CGFloat

    //
    init(pageWidth: CGFloat,
         contentSize: CGSize,
         leftPercent: Binding<CGFloat>,
         @ViewBuilder content: () -> Content) {
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        context.coordinator.scrollView = scrollView
        
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
        
        let host = UIHostingController(rootView: content)
        vc.addChild(host)
        scrollView.addSubview(host.view)
        host.didMove(toParent: vc)
        context.coordinator.host = host
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollView = context.coordinator.scrollView!
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation {
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }

            
//            print("scrollViewDidEndDecelerating \(scrollView.contentOffset)")
        }
    }
}

//struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
//    // TODO:un to do
//    
//    let pageWidth: CGFloat
//    let contentSize: CGSize
//    let content: Content
//
//    @State var leftPercent: CGFloat = 0
//
//    //
//    init(pageWidth: CGFloat,
//         contentSize: CGSize,
//       @ViewBuilder content: () -> Content) {
//
//        self.pageWidth = pageWidth
//        self.contentSize = contentSize
//        self.content = content()
//    }
//
//
//    // func about UIViewControllerRepresentable
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//
//
//        let scrollView = UIScrollView()
//        scrollView.bounces = false
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.isPagingEnabled = true
//        scrollView.delegate = context.coordinator
//
//        // 把scrollview 放到coordinator中去
//        context.coordinator.scrollView = scrollView
//
//        let vc = UIViewController()
//        vc.view.addSubview(scrollView)
//
//        // 把swift ui上的content内容显示到UIKit的scroll view上面
//        // 桥接的作用
//        let host = UIHostingController(rootView: content)
//        // 父级控制器添加二级控制器
//        vc.addChild(host)
//
//        // scrollview 添加二级控制器的view
//        scrollView.addSubview(host.view)
//        // 告诉系统已经添加到vc层级中
//        host.didMove(toParent: vc)
//        // 把host 装载到协调器中
//        context.coordinator.host = host
//
//        return vc
//    }
//
//
//    func updateUIViewController(_ uiViewController:  UIViewController, context: Context) {
//
//        let scrollView = context.coordinator.scrollView!
//        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
//        scrollView.contentSize = contentSize
//        scrollView.setContentOffset(CGPoint(x:leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
//        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
//
//    }
//
//
//    class Coordinator: NSObject, UIScrollViewDelegate {
//
//        let parent: HScrollViewController
//        var scrollView: UIScrollView!
//        var host: UIHostingController<Content>!
//
//        init(parent: HScrollViewController) {
//            self.parent = parent
//        }
//
//
//        // scroll deleagte
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//            print("scrollViewDidEndDecelerating \(scrollView.contentOffset)")
//        }
//    }
//}


