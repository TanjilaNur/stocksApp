//
//  StocksWidget.swift
//  StocksWidget
//
//  Created by TanjilaNur-00115 on 2/11/23.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct StocksWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        StocksWidget()
    }
}

struct StocksWidget: Widget {
    let kind: String = "StocksWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            StocksWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Stocks Widget")
        .description("This is a widget of Stocks App.")
        .supportedFamilies([.systemMedium])
    }
}

struct StocksWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StocksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            StocksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
