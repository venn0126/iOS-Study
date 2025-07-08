//
//  WidgetCommunicationService.swift
//  GTSwiftUITest
//
//  Created by Augus Venn on 2025/7/7.
//

import Foundation


// 定义可能的操作类型
enum WidgetAction: String {
    case playPause = "playPause"
    case next = "next"
    case previous = "previous"
   // 可扩展更多操作...
}

class WidgetCommunicationService {
    // 单例模式
    static let shared = WidgetCommunicationService()
    
    // App Group ID
    private let appGroupID = "group.com.yourcompany.yourapp"
    private let userDefaults: UserDefaults?
    
    // 键名定义
    private struct Keys {
        static let lastAction = "lastWidgetAction"
        static let actionTimestamp = "actionTimestamp"
        static let appLaunchedBefore = "appLaunchedBefore"
        static let playArrayModel = "playArrayModel"
    }
    
    private init() {
        userDefaults = UserDefaults(suiteName: appGroupID)
    }
    
    // Widget 调用：记录操作
    func recordAction(_ action: WidgetAction) {
        userDefaults?.setValue(action.rawValue, forKey: Keys.lastAction)
        userDefaults?.setValue(Date().timeIntervalSince1970, forKey: Keys.actionTimestamp)
        userDefaults?.synchronize()
    }
    
    // App 调用：检查是否有新操作
    func checkForNewAction() -> WidgetAction? {
        guard let actionString = userDefaults?.string(forKey: Keys.lastAction),
              let action = WidgetAction(rawValue: actionString),
              let timestamp = userDefaults?.double(forKey: Keys.actionTimestamp) else {
            return nil
        }
        
        // 检查时间戳，确保是新操作（例如5秒内）
        let currentTime = Date().timeIntervalSince1970
        if currentTime - timestamp < 5.0 {
            // 清除操作记录，避免重复处理
            clearLastAction()
            return action
        }
        
        return nil
    }
    
    // 清除上次操作记录
    private func clearLastAction() {
        userDefaults?.removeObject(forKey: Keys.lastAction)
        userDefaults?.synchronize()
    }
    
    // 检查 App 是否已经启动过
    func isAppLaunchedBefore() -> Bool {
        return userDefaults?.bool(forKey: Keys.appLaunchedBefore) ?? false
    }
    
    // 标记 App 已启动
    func markAppAsLaunched() {
        userDefaults?.setValue(true, forKey: Keys.appLaunchedBefore)
        userDefaults?.synchronize()
    }
    
    func setLoaclPlayModel(model: [String]) {
        userDefaults?.setValue(model, forKey: Keys.playArrayModel)
    }
}

/*
 class AppDelegate: UIResponder, UIApplicationDelegate {
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         // 标记 App 已启动
         WidgetCommunicationService.shared.markAppAsLaunched()
         
         // 设置轮询检查
         setupPolling()
         
         return true
     }
     
     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
         // 处理从 Widget 跳转过来的 URL
         if url.scheme == "yourapp" && url.host == "widget" {
             // 处理首次启动的操作
             handleWidgetAction()
         }
         return true
     }
     
     private func setupPolling() {
         // 使用 Timer 定期检查是否有新操作
         // 在实际应用中，可以根据 App 状态调整轮询频率
         Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
             self?.checkForWidgetActions()
         }
         
         // 添加前台通知监听
         NotificationCenter.default.addObserver(
             self,
             selector: #selector(appWillEnterForeground),
             name: UIApplication.willEnterForegroundNotification,
             object: nil
         )
     }
     
     @objc private func appWillEnterForeground() {
         // App 进入前台时立即检查
         checkForWidgetActions()
     }
     
     private func checkForWidgetActions() {
         if let action = WidgetCommunicationService.shared.checkForNewAction() {
             // 根据操作类型执行相应动作
             switch action {
             case .playPause:
                 // 执行播放/暂停
                 YourPlayerManager.shared.togglePlayPause()
             case .next:
                 // 下一首
                 YourPlayerManager.shared.nextTrack()
             // 处理其他操作...
             default:
                 break
             }
         }
     }
     
     private func handleWidgetAction() {
         // 处理首次启动的操作
         // 可以根据需要执行特定操作
     }
 }
 */
