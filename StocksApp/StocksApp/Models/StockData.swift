//
//  StockData.swift
//  StocksApp
//
//  Created by TanjilaNur-00115 on 8/11/23.
//

import Foundation

/// StockData Model
struct StockData: Codable, Identifiable {
    struct MetaData: Codable {
        let information: String
        let symbol: String
        let lastRefreshed: String
        let interval: String
        let outputSize: String
        let timeZone: String
        
        /// CodingKeys to map JSON keys to Swift property names
        private enum CodingKeys: String, CodingKey {
            case information = "1. Information"
            case symbol = "2. Symbol"
            case lastRefreshed = "3. Last Refreshed"
            case interval = "4. Interval"
            case outputSize = "5. Output Size"
            case timeZone = "6. Time Zone"
        }
    }
    
    /// StockDataEntry Model
    struct StockDataEntry: Codable {
        let open: String
        let high: String
        let low: String
        let close: String
        let volume: String
        
        /// CodingKeys to map JSON keys to Swift property names
        private enum CodingKeys: String, CodingKey {
            case open = "1. open"
            case high = "2. high"
            case low = "3. low"
            case close = "4. close"
            case volume = "5. volume"
        }
    }
    
    /// Generate a unique identifier for each instance
    let id = UUID()
    
    /// Properties for metadata and time series data
    let metaData: MetaData
    let timeSeries5min: [String: StockDataEntry]
    
    /// Computed property to get the latest closing value
    var latestClose: String {
        timeSeries5min.first?.value.close ?? "NaN"
    }
    
    /// Computed property to normalize and scale close values
    var closeValues: [Double] {
        let rawValues = timeSeries5min.values.map { Double($0.close)! }
        let max = rawValues.max()!
        let min = rawValues.min()!
        
        return rawValues.map { ($0 - min * 0.95) / (max - min * 0.95) }
    }
    
    /// CodingKeys for mapping JSON key, metaData & timeSeries5min, to Swift property names
    private enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries5min = "Time Series (5min)"
    }
}
