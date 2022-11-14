//
//  RecognisedTextDataSource.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 14/11/22.
//

import Foundation
import UIKit
import Vision

protocol RecognizedTextDataSource: AnyObject {
    func addRecognizedText(recognizedText: [VNRecognizedTextObservation])
}
