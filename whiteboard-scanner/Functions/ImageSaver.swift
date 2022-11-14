//
//  ImageSaver.swift
//  whiteboard-scanner
//
//  Created by T Krobot on 14/11 22.
//

import UIKit

class ImageSaver: NSObject {
    
    func writeToPhotoAlbum(image: UIImage) {
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        print("Save Finished! ")
        
    }
    
}
