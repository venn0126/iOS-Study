//
//  ViewController.swift
//  UIScrollViewTest
//
//  Created by Augus on 2020/7/23.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        
        scrollView.contentSize = CGSize(width: view.frame.width * 2, height: 300)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView);
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        label1.text = "label1"
        label1.backgroundColor = .green
        scrollView.addSubview(label1)
        
        
        let label2 = UILabel(frame: CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: 300))
        label2.text = "label2"
        label2.backgroundColor = .gray
        scrollView.addSubview(label2)
        
        
        let button = UIButton(frame: CGRect(x: 0, y: 350, width: 100, height: 100))

        button.addTarget(self, action: #selector(self.clickButton), for: .touchUpInside)
        button.backgroundColor = .red
        button.setTitle("滑动", for: .normal)
        view.addSubview(button)
        
    }

    
    
    @objc private func clickButton() {
        
        print("click button--%f",scrollView.contentOffset.x)
        
        let width = view.bounds.width
        
        // 水平偏移量小于屏幕宽度的一半就在左侧，反之就在右侧
        if scrollView.contentOffset.x < width * 0.5 {
            scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(.zero, animated: true)

        }
    }
}


extension ViewController: UISceneDelegate {

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scroll view did \(scrollView.contentOffset)")
//    }
    
    // 停止减速的时候调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating \(scrollView.contentOffset)")

    }
}

