//
//  SightWordsApp.swift
//  SightWords
//
//  Created by Sam Johnson on 10/5/20.
//

import SwiftUI

@main
struct SightWordsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
