//
//  StocksAppApp.swift
//  StocksApp
//
//  Created by TanjilaNur-00115 on 1/11/23.
//

import SwiftUI

@main
struct StocksAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
