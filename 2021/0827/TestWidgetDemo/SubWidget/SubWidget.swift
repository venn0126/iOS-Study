//
//  SubWidget.swift
//  SubWidget
//
//  Created by Augus on 2021/8/28.
//

import WidgetKit
import SwiftUI
import Intents


/**

/// 为小组件展示提供一切必要信息的的结构体，必须实现`IntentTimelineProvider`协议
struct Provider: IntentTimelineProvider {
    // 占位图，网络错误，系统错误的时候会展示
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    // 编辑屏幕在左上角选择添加Widget，第一次展示时会调用该方法
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    // 在这个方法内可以进行网络请求等数据处理，
    // 拿到的数据保存在对应的entry中，调用completion之后会到刷新小组件
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


/// 实现`TimelineEntry`协议，用来保存所需的数据
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}


/// 展示的视图的载体，自定义界面搭建等
struct SubWidgetEntryView : View {
    var entry: Provider.Entry
    
    // 尺寸环境变量
    @Environment(\.widgetFamily) var family

    var body: some View {
        
        switch family {
        case .systemSmall:
            // 小尺寸
            
            Text(entry.date, style: .time)
        case .systemMedium:
            // 中尺寸
            Text(entry.date, style: .time)

        default:
            Text(entry.date, style: .time)

        }
    }
}


//@main 代表着Widget的主入口，系统从这里加载

// kind:是Widget的唯一标识
// IntentConfiguration：初始化配置代码
// configurationDisplayName：添加编辑界面的展示标题
// description：添加编辑界面展示的描述内容
// supportedFamilies：这里可以限制要提供展示三个样式中的哪几个，不设置则全部支持
struct SubWidget: Widget {
    let kind: String = "SubWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SubWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Augus Widget")
        .description("This is an example for augus's widget.")
//        .supportedFamilies([.sys])
    }
}

 */


@main
struct SubWidgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        
        PoetryWidget()

    } 
}



/// 小组件预览界面，需实现`PreviewProvider`协议，实时查看
//struct SubWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        SubWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
