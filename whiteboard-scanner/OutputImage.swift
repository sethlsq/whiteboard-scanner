//
//  OutputImage.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 20/11/22.
//

import Foundation

struct OutputImage: Identifiable, Codable {
    var id = UUID()
    var imgData: [Data] = []
}
