//
//  TagClass.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 28/11/22.
//

import Foundation

class TagClass: ObservableObject {
    
    let characterLimit = 50
    
    @Published var userInput = "" {
        didSet {
            if userInput.count > characterLimit {
                userInput = String(userInput.prefix(characterLimit))
            }
        }
    }
}
