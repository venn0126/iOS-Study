//
//  ContentView.swift
//  TestURLSession
//
//  Created by Augus on 2020/7/27.
//  Copyright © 2020 Fosafer. All rights reserved.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State private var text = ""
    
    
    var body: some View {
        
        VStack(spacing: 50){
            
            Text(text).font(.title)
            
            
            Button(action: {
//                print("开始")
                self.startLoad()
//                self.amStartLoad()
                
//                self.data { (data) in
//
//                    print("444---\(data)--\(Thread.current)")
//                }
                    
                
            
                
            }){
                Text("Start").font(.largeTitle)
            }
            
            Button(action: {
                self.text = ""
                
            }){
                Text("Clear").font(.largeTitle)
            }
            
        }
    }
    
    func data(closure:@escaping ((Any) -> Void)) {
        print("111--\(Thread.current)")
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("333--\(Thread.current)")
                closure("555")
            }
        }
        
        print("222--\(Thread.current)")
    }
    
    
    func startLoad(){
        
        NetworkAPI.recommandPostList{ result in

            switch result {
            case let .success(list):
                self.updateText("list count \(list.list.count)")

            case let .failure(error):
                self.updateText(error.localizedDescription)

            }

        }
        
        
//        NetworkManger.shared.requestGet(path: "PostListData_hot_1.json", params: nil) { (result) in
//
//            switch result {
//            case let .success(data):
//                guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
//
//                    self.updateText("decode data error")
//                    return
//
//                }
//
//                self.updateText("list count \(list.list.count)")
//                break
//
//            case let .failure(error):
//                // handle data
//                self.updateText(error.localizedDescription)
//                break
//            }
//        }
        
        
//       let urlString = "https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/PostListData_recommend_1.json"
//        let url = URL(string: urlString)!
//        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
//
//            if let error = error {
//                self.updateText(error.localizedDescription)
//                return
//            }
//
//            guard let urlResponse = urlResponse as? HTTPURLResponse,urlResponse.statusCode == 200 else {
//
//                self.updateText("invalid response")
//                return
//            }
//
//            guard let data = data else {
//
//                self.updateText("invalid data")
//                return
//            }
//
//            guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
//
//                self.updateText("decode data error")
//                return
//
//            }
//
//            self.updateText("list count \(list.list.count)")
//        }
//        task.resume()
        
    }
    
    
    func amStartLoad() {
        
        let url =  "https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/PostListData_recommend_1.json"
        
        AF.request(url).responseData { response in
            switch response.result {
                
            case let .success(data):
                // handle data
                guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
                    
                    self.updateText("decode data error")
                    return
                    
                }
                
                self.updateText("list count \(list.list.count)")
                
                break
                
            case let .failure(error):
                // handle data
                self.updateText(error.localizedDescription)
                break
            }
        }
    }


    func updateText(_ text: String) {
        // af default main use
        DispatchQueue.main.async {
            self.text = text
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
