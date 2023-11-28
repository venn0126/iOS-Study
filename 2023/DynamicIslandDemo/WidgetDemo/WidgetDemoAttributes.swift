//
//  WidgetDemoAttributes.swift
//  DynamicIslandDemo
//
//  Created by chenhao on 2022/11/14.
//

import ActivityKit

struct WidgetDemoAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
