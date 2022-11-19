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
        
        whiteboards = finalWhiteboards
    }
}
