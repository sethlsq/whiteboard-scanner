//
//  Whiteboard.swift
//  whiteboard-scanner
//
//  Created by T Krobot on 18/11/22.
//

import Foundation

struct Whiteboard: Identifiable, Codable {
    var id = UUID()
    var title: String = ""
    var description: String = ""
    var dateCreatedString: String = ""
    var dateCreated = Date()
    var category: String = ""
    var isPinned: Bool = false
    var imageData: [Data] = []
}

enum category: Codable {
    case none
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case grey
    case brown
    
}

