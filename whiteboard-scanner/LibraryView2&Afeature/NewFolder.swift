//
//  NewFolder.swift
//  whiteboard-scanner
//
//  Created by Alina Fu on 18/11/65 BE.
//

import SwiftUI

struct NewFolder: View {
    
    @State var folder = ""
    
    @Binding var folders: [Folder]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Folder name", text: $folder)
            
            Button("Save folder") {
                // Do some magic to save todo
                folders.append(Folder(name: folder))
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewFolder_Previews: PreviewProvider {
    static var previews: some View {
        NewFolder(folders: .constant([]))
    }
}
