//
//  LibraryDetail.swift
//  whiteboard-scanner
//
//  Created by Alina Fu on 15/11/65 BE.
//

import SwiftUI

struct LibraryDetail: View {
    @Binding var folder: Folder
    
    var body: some View {
        TextField("Folder name", text: $folder.name)
         .multilineTextAlignment(.center)
    }
}

struct LibraryDetail_Previews: PreviewProvider {
    static var previews: some View {
        LibraryDetail(folder: .constant(Folder(name: "math")))
    }
}
