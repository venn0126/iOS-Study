//
//  DummyControlControl.swift
//  DummyControl
//
//  Created by Augus Venn on 2024/7/18.
//

import AppIntents
import SwiftUI
import WidgetKit

struct DummyControlToggleDemo: ControlWidget {
    static let kind: String = "com.gt.ControlWidgetDemo.DummyControlToggleDemo"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            // Toggle Mode
            ControlWidgetToggle(isOn: ShareManager.shared.isTurnedOn, action: DummyControlIntent()) {
                Text("ToggleDemo")
            } valueLabel: { isTurnedOn in
                Image(systemName: isTurnedOn ? "fan.fill" : "fan")
                Text(isTurnedOn ? "Toggle On" : "Toggle Off")
            }
        }
        .displayName("ControlWidgetToggle")
        .description("ControlWidgetToggle open the link")
    }
}


struct DummyControlButtonDemo: ControlWidget {
    static let kind: String = "com.gt.ControlWidgetDemo.DummyControlButtonDemo"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: CaffineUpdateIntent(amount: 10.0)) {
                Image("sohu.news")
                Text("Control Button Test 123 AugusControl Button Test 123 Augus")
                let amount = ShareManager.shared.caffineInTake
                Text("\(String(format: "%1.fControl Button Test 123 AugusControl Button Test 123 Augus",amount)) mgs")
            }
        }
        .displayName("ControlWidgetButton")
        .description("DummyControlButton open the link")
    }
}

struct CaffineUpdateIntent: AppIntent {
    init() {
        
    }
    
    init(amount: Double) {
        self.amount = amount
    }
    
    static var title: LocalizedStringResource { "Update Caffine In Take" }
    @Parameter(title: "Amount Taken")
    var amount: Double
    
    func perform() async throws -> some IntentResult {
        /// 更新内容
        ShareManager.shared.caffineInTake += amount
        return .result()
    }
}


struct DummyControlIntent: SetValueIntent {
    static var title: LocalizedStringResource { "Turned On Living Room Fan" }
    
    @Parameter(title: "is Turned On")
    var value: Bool
    
    func perform() async throws -> some IntentResult {
        /// 更新内容
        ShareManager.shared.isTurnedOn = value
        
        return .result()
    }
}

/*
 /// Control Widget that opens a URL
 
 @available(iOS 18.0, watchOS 11.0, macOS 15.0, visionOS 2.0, *)
 struct MyIntent: AppIntent {
     static let title: LocalizedStringResource = "My Intent"
     static var openAppWhenRun: Bool = true

     init() {}

     @MainActor
     func perform() async throws -> some IntentResult & OpensIntent {
         guard let url = URL(string: "myapp://myappintent") else {
             // throw an error of your choice here
         }

         return .result(opensIntent: OpenURLIntent(deepLink))
     }
 }
 
 */
