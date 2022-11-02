//
//  data.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 2/11/22.
//

import Foundation
import SwiftUI
import UIKit

struct ScanButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .frame(maxWidth: .infinity)
    }
}
