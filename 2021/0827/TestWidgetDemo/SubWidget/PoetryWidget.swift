//
//  PoetryWidget.swift
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

import WidgetKit
import SwiftUI
import Intents


struct PoetryProvider: IntentTimelineProvider {

    // 实现默认视图
    func placeholder(in context: Context) -> PoetryEntry {
        let poetry = Poetry(content: "窗前明月光，疑是地上霜", origin: "静夜思", author: "李白")
        return PoetryEntry(date: Date(), poetry: poetry)
    }

    // 编辑屏幕在左上角选择添加Widget，第一次展示时会调用该方法
    // 在组件的添加页面可以看到效果
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PoetryEntry) -> ()) {
        let poetry = Poetry(content: "重叠不可思，思此谁能惬", origin: "芳树", author: "萧衍")
        let entry = PoetryEntry(date: Date(), poetry: poetry)
        completion(entry)
    }

    // 在这个方法内可以进行网络请求等数据处理，
    // 拿到的数据保存在对应的entry中，调用completion之后会到刷新小组件
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        let currentDate = Date()
        // The next update time is 5 min
        let updateDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)
        URLRequest.method { result in
            
            let poetry: Poetry
            if case .success(let response) = result {
                poetry = response
            } else {
                poetry = Poetry(content: "诗词加载失败，请稍后重试", origin: "提醒", author: "Augus")
            }
            
            let entry = PoetryEntry(date: currentDate, poetry: poetry)
            let timeline = Timeline(entries: [entry], policy: .after(updateDate!))
            completion(timeline)
        }
        
    }
}

struct PoetryEntry: TimelineEntry {
    let date: Date
    let poetry: Poetry
}


/// 展示的视图的载体，自定义界面搭建等
struct PoetryWidgetEntryView : View {
//    var entry: Provider.Entry
    let entry: PoetryEntry
    
    // 尺寸环境变量
    @Environment(\.widgetFamily) var family

    var body: some View {
        
//        switch family {
//        case .systemSmall:
//            // 小尺寸
//
//            Text(entry.date, style: .time)
//        case .systemMedium:
//            // 中尺寸
//            Text(entry.date, style: .time)
//
//        default:
//            Text(entry.date, style: .time)
//
//        }
        
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.poetry.origin)
                .font(.system(size: 20))
                .fontWeight(.bold)
            Text(entry.poetry.author)
                .font(.system(size: 16))
            Text(entry.poetry.content)
                .font(.system(size: 18))
        }
        .frame(minWidth: 0, idealWidth: nil, maxWidth: .infinity, minHeight: 0, idealHeight: nil, maxHeight: .infinity, alignment: .leading)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.init(red: 144 / 255.0, green: 252 / 255.0, blue: 231 / 255.0),.init(red: 50 / 204.0, green: 188 / 255.0, blue: 231 / 255.0)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        
    }
}

struct PoetryWidget: Widget {
    let kind: String = "PoertryWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: PoetryProvider()) { entry in
            PoetryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("每日一篇")
        .description("感受诗词不一样的魅力")
    }
}



//struct PoetryWidget: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct PoetryWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        PoetryWidget()
//    }
//}
