//
//  HomeViewModel.swift
//  StocksApp
//
//  Created by TanjilaNur-00115 on 9/11/23.
//

import Foundation
import SwiftUI
import Combine

/// ViewModel class responsible for managing stock data in the application
final class HomeViewModel: ObservableObject {
    
    /// Core Data context for interacting with the persistent store
    private let context = PersistenceController.shared.container.viewContext
    
    /// Set of cancellables to manage Combine subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    /// Published property for updating the UI with the fetched stock data
    @Published var stockData: [StockData] = []
    
    /// Published properties for handling user input and validation
    @Published var symbolValid = false
    @Published var symbol = ""
    
    /// Array to store stock entities fetched from Core Data
    @Published var stockEntities: [StockEntity] = []
    
    /// Initializer to set up the ViewModel and load existing data
    init() {
        loadFromCoreData()
        loadAllSymbols()
        
        validateSymbolField()
    }
    
    /// Set up Combine publisher to validate the symbol field
    func validateSymbolField() {
        $symbol
            .sink { [unowned self] newValue in
                self.symbolValid = !newValue.isEmpty
            }
            .store(in: &cancellables)
    }
    
    /// Fetch stock entities from Core Data
    func loadFromCoreData() {
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    /// Add a new stock to Core Data and fetch its data
    func addStock() {
        let newStock = StockEntity(context: context)
        newStock.symbol = symbol
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        stockEntities.append(newStock)
        getStockData(for: symbol)
        
        symbol = ""
    }
    
    /// Delete a stock from both stockData and Core Data
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        stockData.remove(at: index)
        let stockToRemove = stockEntities.remove(at: index)
        
        context.delete(stockToRemove)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    /// Load stock data for all symbols in stockEntities
    func loadAllSymbols() {
        stockData = []
        stockEntities.forEach { stockEntity in
            getStockData(for: stockEntity.symbol ?? "")
        }
    }
    
    /// Fetch stock data from the API using the StockService
    func getStockData(for symbol: String) {
        StockService
            .getStockData(for: symbol)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [unowned self] stockData in
                DispatchQueue.main.async {
                    self.stockData.append(stockData)
                }
            }
            .store(in: &cancellables)
    }
}
