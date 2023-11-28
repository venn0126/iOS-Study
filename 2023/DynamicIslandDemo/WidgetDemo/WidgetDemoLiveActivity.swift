//
//  WidgetDemoLiveActivity.swift
//  WidgetDemo
//
//  Created by chenhao on 2022/11/14.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetDemoLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetDemoAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("锁屏界面展示效果")
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.secondary)
                    HStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.blue)
                            .frame(width: 50)
                        Image(systemName: "shippingbox.circle.fill")
                            .foregroundColor(.white)
                            .padding(.leading, -25)
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white.opacity(0.5))
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white.opacity(0.5))
                        Text(timerInterval: Date()...Date().addingTimeInterval(15 * 60), countsDown: true)
                            .bold()
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white.opacity(0.5))
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white.opacity(0.5))
                        Image(systemName: "house.circle.fill")
                            .foregroundColor(.green)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
                Text("锁屏界面展示效果")
            }.padding(15)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("😁Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack{
                        Text("T😁T")
                        Text(timerInterval: Date()...Date().addingTimeInterval(15 * 60), countsDown: true)
                            .multilineTextAlignment(.center)
                        }
                    }
  
                DynamicIslandExpandedRegion(.center) {
                    VStack{
                        Spacer().frame(height: 10)
                        Text("center value：\(context.state.value)")
                        Spacer().frame(height: 10)
                    }
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("😭Bottom name：\(context.attributes.name)😭")
                    // more content
                }
            } compactLeading: {
                Text("L😁L")
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } compactTrailing: {
                    Text(timerInterval: Date()...Date().addingTimeInterval(15 * 60), countsDown: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
               
                
            } minimal: {
                Image(systemName: "timer.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
