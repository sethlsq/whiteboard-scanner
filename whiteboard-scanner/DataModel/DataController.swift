//
//  DataController.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 2/11/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "WhiteboardModell")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved.")
        } catch {
            print("Data not saved!")
        }
    }
}
