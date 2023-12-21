//
//  StockService.swift
//  StocksApp
//
//  Created by TanjilaNur-00115 on 2/11/23.
//

import Foundation
import Combine

/// Struct for the StockService
struct StockService {
    
    /// A static function to get stock data for a given symbol using Combine's AnyPublisher
    static func getStockData(for symbol: String) -> AnyPublisher<StockData, Error> {
        
        /// Construct the URL for the Alpha Vantage API with the Symbol from parameters
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=5min&apikey=AXRSN8I2FA5T08ME")!
        
        /// Use URLSession's dataTaskPublisher to initiate a network request
        return URLSession.shared
            .dataTaskPublisher(for: url)
            
            /// tryMap to handle errors and extract the data from the response
            .tryMap { element -> Data in
                
                /// Check if the response is a successful HTTP response (status code 200)
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    /// If not, throw a URLError with a badServerResponse code
                    throw URLError(.badServerResponse)
                }
                
                /// Return the data from the network response
                return element.data
            }
            
            /// Use decode to parse the JSON data into the StockData model using JSONDecoder
            .decode(type: StockData.self, decoder: JSONDecoder())
            
            /// Erase the type to AnyPublisher to hide implementation details
            .eraseToAnyPublisher()
    }
}

