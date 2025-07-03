//
//  LocalNotificationManager.swift
//  GTSwiftUITest
//
//  Created by Augus Venn on 2025/7/4.
//

import Foundation
import UserNotifications

/// 本地通知管理器，支持请求权限、定时发送、清除通知等功能，可扩展
class LocalNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    /// 单例
    static let shared = LocalNotificationManager()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    /// 请求本地通知权限
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    /// 发送本地通知（多少秒后提醒）
    /// - Parameters:
    ///   - title: 通知标题
    ///   - body: 通知内容
    ///   - after: 多少秒后触发
    ///   - identifier: 通知唯一标识，默认自动生成
    ///   - userInfo: 附加信息，默认空
    func sendNotification(title: String, body: String, after seconds: TimeInterval, identifier: String = UUID().uuidString, userInfo: [AnyHashable: Any] = [:]) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.userInfo = userInfo
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("[LocalNotificationManager] 通知发送失败: \(error)")
            } else {
                print("[LocalNotificationManager] 通知已安排 (\(identifier))")
            }
        }
    }
    
    /// 移除指定通知
    /// - Parameter identifier: 通知唯一标识
    func removeNotification(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    /// 清除所有未触发的通知
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    /// 清除所有已送达的通知（通知中心里的）
    func removeAllDeliveredNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    /// 获取所有未触发的通知
    func getAllPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            completion(requests)
        }
    }
    
    /// 获取所有已送达的通知
    func getAllDeliveredNotifications(completion: @escaping ([UNNotification]) -> Void) {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            completion(notifications)
        }
    }
    
    /// UNUserNotificationCenterDelegate: 前台收到通知处理（可扩展）
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        /// 前台展示通知
        completionHandler([.banner, .sound, .badge])
    }
    
    /// UNUserNotificationCenterDelegate: 响应通知点击（可扩展）
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        /// 这里可以根据 identifier 或 userInfo 做自定义处理
        print("[LocalNotificationManager] 用户响应通知: \(response.notification.request.identifier)")
        completionHandler()
    }
}
