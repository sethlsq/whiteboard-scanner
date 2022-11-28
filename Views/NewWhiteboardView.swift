//
//  NewWhiteboardView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct NewWhiteboardView: View {
    
    @State var whiteboardTitle = ""
    @State var whiteboardDesc = ""
    @ObservedObject var whiteboardManager: WhiteboardManager
    @Environment(\.presentationMode) var presentationMode
    @Binding var outputImage: OutputImage
    @State var isNoTitleAlertShown = false
    @State var isNewTagAlertShown = false
    @ObservedObject var tagClass = TagClass()
    @State var selectedTags: [String]
    
    var body: some View {
        NavigationView {
            List {
                Section {
//                    ScrollView(.horizontal) {
                    Image(uiImage: UIImage(data: outputImage.imgData[outputImage.imgData.count - 1])!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 256, height: 128)
                        .cornerRadius(12)
//                    }
                }
                Section(header: Text("options")) {
                    TextField("Title", text: $whiteboardTitle)
                    TextField("Description", text: $whiteboardDesc, axis: .vertical)
                    Button {
                        isNewTagAlertShown = true
                    } label: {
                        Text("Add tag")
                    }
                }
                Section() {
                    Button("Save") {
                        if (whiteboardTitle == "") {
                            isNoTitleAlertShown = true
                        } else {
                            whiteboardManager.whiteboards.append(Whiteboard(title: whiteboardTitle, description: whiteboardDesc, dateCreatedString: Date.now.formatted(date: .long, time: .shortened), dateCreated: Date(), whiteboardTags: selectedTags, imageData: outputImage.imgData))
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("New Whiteboard")
            .alert("Title cannot be empty.", isPresented: $isNoTitleAlertShown) {
                Button(role: .none) {
                    isNoTitleAlertShown = false
                } label: {
                    Text("Dismiss")
                }
            }
            .alert("Assign Tag", isPresented: $isNewTagAlertShown) {
                TextField("Tag", text: $tagClass.userInput)
                Button("Cancel", role: .cancel, action: {})
                Button {
                    selectedTags.append(tagClass.userInput)
                } label: {
                    Text("Add")
                }
                .disabled(tagClass.userInput.isEmpty)
            }
        }
    }
}
//
//struct NewWhiteboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewWhiteboardView(whiteboards: .constant([]))
//    }
//}
