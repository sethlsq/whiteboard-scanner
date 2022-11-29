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
    var dateCreatedString: String {
        dateCreated.formatted(date: .long, time: .shortened)
    }
    var dateEditedString: String {
        dateEdited.formatted(date: .long, time: .shortened)
    }
    var dateCreated = Date()
    var dateEdited = Date()
    var whiteboardTags: [String]
    var isPinned: Bool = false
    var imageData: [Data] = []
}


