//
//  NWUITestApp.swift
//  com.nw.ui.watchos Extension
//
//  Created by Augus on 2021/7/14.
//

import SwiftUI

@main
struct NWUITestApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
