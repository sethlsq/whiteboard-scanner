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
    var catagory: String = ""
    var isPinned: Bool = false
    var imageData: [Data] = []
    
    
}

enum catagory: Codable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    
}

