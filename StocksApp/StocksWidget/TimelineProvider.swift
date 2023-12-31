//
//  TimelineProvider.swift
//  StocksWidgetExtension
//
//  Created by TanjilaNur-00115 on 2/11/23.
//

import Combine
import WidgetKit
import Intents

class Provider: IntentTimelineProvider {
    
    /// Placeholder provider
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil)
    }
    
    /// Snapshot Provide
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        createTimelineEntry(date: Date(), configuration: configuration, completion: completion)
    }
    
    /// Timeline provider
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        createTimeline(date: Date(), configuration: configuration, completion: completion)
    }
    
    var cancellables: Set<AnyCancellable> = []
    
    func createTimelineEntry(date: Date, configuration: ConfigurationIntent, completion: @escaping (SimpleEntry) -> ()) {
        StockService
            .getStockData(for: configuration.customSymbol?.identifier ?? "IBM")
            .sink { _ in } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuration, stockData: stockData)
                completion(entry)
            }
            .store(in: &cancellables)
    }
    
    func createTimeline(date: Date, configuration: ConfigurationIntent, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        StockService
            .getStockData(for: configuration.customSymbol?.identifier ?? "IBM")
            .sink { _ in } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuration, stockData: stockData)
                
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
            .store(in: &cancellables)
    }
}
