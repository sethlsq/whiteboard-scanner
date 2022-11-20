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
    var dateCreated = Date()
    var imageName: String {return title}
    var thumbnailName: String {return title}
    var imageData: [Data] = []
    
//    var whiteboardImage = images
//    var whiteboardImageCount: Int = numberOfPages
}
