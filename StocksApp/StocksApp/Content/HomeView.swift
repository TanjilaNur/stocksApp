//
//  ContentView.swift
//  StocksApp
//
//  Created by TanjilaNur-00115 on 8/11/23.
//

import SwiftUI
import CoreData

/// Home View
struct HomeView: View {
    
    /// ObservedObject to observe changes in the view model
    @ObservedObject private var model = HomeViewModel()
    
    var body: some View {
        
        /// Navigation View
        NavigationView {
            
            /// List to display stocks and user input
            List {
                
                /// Search TextField and Add Button
                HStack {
                    TextField("Symbol", text: $model.symbol)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add", action: model.addStock)
                        .disabled(!model.symbolValid)
                }
                
                /// Display all added stocks using ForEach stockData is not empty
                if !model.stockData.isEmpty {
                    ForEach(model.stockData) { stock in
                        
                        /// Stock information row
                        HStack {
                            Text(stock.metaData.symbol)
                            
                            Spacer()
                            
                            /// Line chart to visualize stock close values
                            LineChart(values: stock.closeValues)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: 150, height: 50)
                            
                            /// Display the latest close value
                            VStack(alignment: .trailing) {
                                Text(stock.latestClose)
                            }
                            .frame(width: 100)
                        }
                    }
                    
                    /// Enable deletion of stocks
                    .onDelete(perform: model.delete(at:))
                }
            }
            
            /// Set navigation title and toolbar
            .navigationTitle("My Stocks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    
                    /// Edit button for enabling editing mode
                    EditButton()
                }
            }
        }
    }
}

/// PreviewProvider for the HomeView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

