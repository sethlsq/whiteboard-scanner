//
//  DocumentCameraView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 14/11/22.
//

import Foundation
import UIKit
import SwiftUI
import VisionKit
import Vision

struct DocumentCameraView: UIViewControllerRepresentable {
    
    var onComplete: (([UIImage]) -> Void)
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = context.coordinator
        
        return documentCameraViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        
        var parent: DocumentCameraView
        init(parent: DocumentCameraView) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var numberOfPages = scan.pageCount
            let images = (0..<numberOfPages).map {
                scan.imageOfPage(at: $0)
            }
            parent.onComplete(images)
        }
    }
}
