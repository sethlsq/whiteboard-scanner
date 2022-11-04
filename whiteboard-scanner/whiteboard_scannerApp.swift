//
//  whiteboard_scannerApp.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI

@main
struct whiteboard_scannerApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
