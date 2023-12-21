//
//  StocksWidgetView.swift
//  StocksWidgetExtension
//
//  Created by TanjilaNur-00115 on 3/11/23.
//

import Combine
import SwiftUI
import WidgetKit

struct StocksWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
            case .systemMedium:
                VStack {
                    Text(entry.configuration.customSymbol?.identifier ?? "IBM")
                    
                    LineChart(values: entry.stockData?.closeValues ?? [])
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 150, height: 50)
                }
            default:
                Text("Not implemented")
        }
    }
}
