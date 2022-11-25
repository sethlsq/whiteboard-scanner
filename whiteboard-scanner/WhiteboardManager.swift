//
//  WhiteboardManager.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import Foundation
import SwiftUI

class WhiteboardManager: ObservableObject {
    @Published var whiteboards: [Whiteboard] = [] {
        didSet {
            save()
        }
    }
    
    @Published var searchTerm = ""
    
    let sampleWhiteboards: [Whiteboard] = []
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "whiteboards.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedwhiteboards = try? propertyListEncoder.encode(whiteboards)
        try? encodedwhiteboards?.write(to: archiveURL, options: .noFileProtection)
    }
    
    var sortedWhiteboards: [Whiteboard] {
        get {
            let shownWhiteboards = searchResults.isEmpty ? whiteboards : searchResults
            return shownWhiteboards
        } set {
            for whiteboard in newValue {
                let whiteboardIndex = whiteboards.firstIndex(where: { $0.id == whiteboard.id })!
                whiteboards[whiteboardIndex] = whiteboard
            }
        }
        
    }
    
    var searchResults: [Whiteboard] {
        
        whiteboards.filter { whiteboard in
            whiteboard.title.lowercased().contains(searchTerm.lowercased())
        }
        
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalWhiteboards: [Whiteboard]!
        
        if let retrievedWhiteboardData = try? Data(contentsOf: archiveURL),
           let decodedWhiteboards = try? propertyListDecoder.decode([Whiteboard].self, from: retrievedWhiteboardData) {
            finalWhiteboards = decodedWhiteboards
        } else {
            finalWhiteboards = sampleWhiteboards
        }
        
        whiteboards = finalWhiteboards.sorted(by: { $0.dateCreated > $1.dateCreated })
    }
}
