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
    @Published var hasSorted = 0
    @Published var searchTerm = ""
    @Published var filterString = ""
    
    var isPinnedNow = false
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
            var sortedWhiteboards: [Whiteboard] = []
            switch hasSorted {
            case 1: sortedWhiteboards = whiteboardsSortedDate
            case 2: sortedWhiteboards = whiteboardsSortedName
            case 3: sortedWhiteboards = tagFilteredWhiteboards(filterString: filterString)
            case 4: sortedWhiteboards = whiteboardsSortedEdited
            default : sortedWhiteboards = whiteboards
            }
            
            let shownWhiteboards = searchResults.isEmpty ? sortedWhiteboards : searchResults
            return shownWhiteboards
        } set {
            for whiteboard in newValue {
                let whiteboardIndex = whiteboards.firstIndex(where: { $0.id == whiteboard.id })!
                whiteboards[whiteboardIndex] = whiteboard
            }
        }
    }
    
    private var searchResults: [Whiteboard] {
        whiteboards.filter { whiteboard in
            whiteboard.title.lowercased().contains(searchTerm.lowercased())
        }
    }
    var whiteboardsSortedDate: [Whiteboard] {
        get {
            whiteboards.sorted {
                $0.dateCreated.compare($1.dateCreated) == .orderedDescending
            }
        } set {
            for whiteboard in newValue {
                let whiteboardIndex = whiteboards.firstIndex(where: { $0.id == whiteboard.id })!
                whiteboards[whiteboardIndex] = whiteboard
            }
        }
    }
    var whiteboardsSortedEdited: [Whiteboard] {
        get {
            whiteboards.sorted {
                $0.dateEdited.compare($1.dateEdited) == .orderedDescending
            }
        } set {
            for whiteboard in newValue {
                let whiteboardIndex = whiteboards.firstIndex(where: { $0.id == whiteboard.id })!
                whiteboards[whiteboardIndex] = whiteboard
            }
        }
    }

    var whiteboardsSortedName: [Whiteboard] {
        get {
            whiteboards.sorted {
                $0.title.compare($1.title) == .orderedAscending
            }
        } set {
            for whiteboard in newValue {
                let whiteboardIndex = whiteboards.firstIndex(where: { $0.id == whiteboard.id })!
                whiteboards[whiteboardIndex] = whiteboard
            }
        }
    }
    
    func tagFilteredWhiteboards(filterString: String) -> [Whiteboard] {
        if filterString.isEmpty {
            return whiteboards
        }
        return whiteboards.filter { whiteboard in
            whiteboard.whiteboardTags.contains(filterString)
        }
    }
//    var tagFilteredWhiteboards: [Whiteboard] {
//        get {
//            whiteboards.filter {
//                $0.whiteboardTags.contains(filterString)
//            }
//        } set {
//            for whiteboard in newValue {
//                let whiteboardIndex = whiteboards.firstIndex(where: { $0.id == whiteboard.id })!
//                whiteboards[whiteboardIndex] = whiteboard
//            }
//        }
//    }
    
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

