//
//  TimelineEntry.swift
//  StocksWidgetExtension
//
//  Created by TanjilaNur-00115 on 2/11/23.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let stockData: StockData?
}
