//
//  IntentHandler.swift
//  StocksAppIntents
//
//  Created by TanjilaNur-00115 on 2/11/23.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    func provideCustomSymbolOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<CustomSymbol>?, Error?) -> Void) {
        
        ///Conguration Symbols
        let symbols: [CustomSymbol] = [
            CustomSymbol(identifier: "AAPL", display: "Apple"),
            CustomSymbol(identifier: "TSLA", display: "Tesla")
        ]

        /// Create a collection with the array of symbols.
        let collection = INObjectCollection(items: symbols)

        /// Call the completion handler, passing the collection.
        completion(collection, nil)
    }
    
}
