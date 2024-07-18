//
//  DummyControlControl.swift
//  DummyControl
//
//  Created by Augus Venn on 2024/7/18.
//

import AppIntents
import SwiftUI
import WidgetKit

struct DummyControlControl: ControlWidget {
    static let kind: String = "com.gt.ControlWidgetDemo.DummyControl"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            // Toggle Mode
//            ControlWidgetToggle(isOn: ShareManager.shared.isTurnedOn, action: DummyControlIntent()) {
//                Text("Living Room")
//            } valueLabel: { isTurnedOn in
//                Image(systemName: isTurnedOn ? "fan.fill" : "fan")
//                Text(isTurnedOn ? "Turned On" : "Turned Off")
//            }
            
            ControlWidgetButton(action: CaffineUpdateIntent(amount: 10.0)) {
                Image(systemName: "cup.and.saucer.fill")
                Text("Caffine In Take")
                let amount = ShareManager.shared.caffineInTake
                Text("\(String(format: "%1.f",amount)) mgs")
            }
        }
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
