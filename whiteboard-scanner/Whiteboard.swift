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
    var dateCreated: String = ""
    var catagory: String = ""
    var imageData: [Data] = []
    
}

enum catagory {
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
