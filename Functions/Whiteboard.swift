//
//  Whiteboard.swift
//  whiteboard-scanner
//
//  Created by T Krobot on 18/11/22.
//

import Foundation

struct Whiteboard: Identifiable, Codable {
    var id = UUID()
    var title: String! = "Title"
    var description: String! = ""
    var datecreated: Int?
}
