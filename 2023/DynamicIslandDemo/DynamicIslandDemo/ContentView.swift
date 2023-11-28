//
//  ContentView.swift
//  DynamicIslandDemo
//
//  Created by chenhao on 2022/11/14.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("点击开启灵动岛")
                .onTapGesture {
                    startActivity()
                }
                .onOpenURL { url in
                    print("\(url)")
                }
            Spacer()
            Text("点击更新灵动岛内容")
                .onTapGesture {
                    updateActivity()
                }
                .onOpenURL { url in
                    print("\(url)")
                }
            Spacer()
            Text("点击结束灵动岛更新")
                .onTapGesture {
                    endActivity()
                }
                .onOpenURL { url in
                    print("\(url)")
                }
            Spacer()
        }
        .padding()
    }
    
    /// 开启灵动岛显示功能
    func startActivity(){
        Task{
            let attributes = WidgetDemoAttributes(name:"我是名字")
            let initialContentState = WidgetDemoAttributes.ContentState(value: 100)
            do {
                let myActivity = try Activity<WidgetDemoAttributes>.request(
                    attributes: attributes,
                    contentState: initialContentState,
                    pushType: nil)
                print("Requested a Live Activity \(myActivity.id)")
                print("已开启灵动岛显示 App切换到后台即可看到")
            } catch (let error) {
                print("Error requesting pizza delivery Live Activity \(error.localizedDescription)")
            }
            
            /*
            do {
                let initialContentState = WidgetDemoAttributes.ContentState(value: 100)

                let activity = try Activity<WidgetDemoAttributes>.request(
                    attributes: attributes,
                    contentState: initialContentState,
                    pushType: .token)
                
                // Register pushToken for updating live activity
                // Create tasks that keeps listening as push tokens rotate for this live activity
                Task {
                    for await data in activity.pushTokenUpdates {
                        let token = data.map {String(format: "%02x", $0)}.joined()
//                        octoprintClient.registerLiveActivityAPNSToken(activityID: activity.id, token: token) { (success: Bool, error: Error?, response: HTTPURLResponse) in
//                            if !success {
//                                // Handle error
//                                NSLog("Error registering Live Activity. HTTP status code \(response.statusCode)")
//                            }
//                        }
                    }
                    NSLog("STOPPED listening for push notifications for LA \(activity.id)")
                }
                
            } catch (let error) {
                NSLog("Error requesting Live Activity \(error.localizedDescription).")
            }
             */
        }
    }
    
    /// 更新灵动岛显示
    func updateActivity(){
        Task{
            let updatedStatus = WidgetDemoAttributes.ContentState(value: 2000)
            for activity in Activity<WidgetDemoAttributes>.activities{
                await activity.update(using: updatedStatus)
                print("已更新灵动岛显示 Value值已更新 请展开灵动岛查看")
            }
        }
    }
    
    /// 结束灵动岛显示
    func endActivity(){
        Task{
            for activity in Activity<WidgetDemoAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
                print("已关闭灵动岛显示")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
