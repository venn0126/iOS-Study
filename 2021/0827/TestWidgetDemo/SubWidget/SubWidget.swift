//
//  SubWidget.swift
//  SubWidget
//
//  Created by Augus on 2021/8/28.
//

import WidgetKit
import SwiftUI
import Intents

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

    // 进行数据的预处理，网络等，转化成Entry
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

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

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

//@main
struct SubWidget: Widget {
    let kind: String = "SubWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SubWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Augus Widget")
        .description("This is an example for augus's widget.")
    }
}

struct HotWidget: Widget {
    
    let kind: String = "HotWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SubWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Hot Widget")
        .description("This is an example for hot's widget.")
    }
}


struct CastWidget: Widget {
    
    let kind: String = "CastWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SubWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Cast Widget")
        .description("This is an example for cast's widget.")
    }
}


@main
struct SNWidgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        SubWidget()
        HotWidget()
        CastWidget()
    } 
}


struct SubWidget_Previews: PreviewProvider {
    static var previews: some View {
        SubWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
