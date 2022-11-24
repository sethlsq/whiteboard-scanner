//
//  NewWhiteboardView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct NewWhiteboardView: View {
    
    @State var whiteboard = ""
    @Binding var whiteboards: [Whiteboard]
    @Environment(\.presentationMode) var presentationMode
    @Binding var outputImage: OutputImage
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ScrollView(.horizontal) {
                        Image(uiImage: UIImage(data: outputImage.imgData[0])!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 128, height: 128)
                                .cornerRadius(12)
                                .padding()
                    }
                }
                Section(header: Text("options")) {
                    TextField("Title", text: $whiteboard)
                    Button("Save") {
                        whiteboards.append(Whiteboard(title: whiteboard, imageData: outputImage.imgData))
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("New Whiteboard")
        }
    }
}

//struct NewWhiteboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewWhiteboardView(whiteboards: .constant([]))
//    }
//}
