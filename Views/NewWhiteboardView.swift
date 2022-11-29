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
                }
                
                Section {
                    Button {
                        isNewTagAlertShown = true
                    } label: {
                        Text("Add Tag")
                    }
                    if selectedTags.isEmpty == false{
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 10) {
                                ForEach (selectedTags, id: \.self) { tag in
                                    Menu {
                                        Button(role: .destructive) {
                                            if let index = selectedTags.firstIndex(of: tag) {
                                                selectedTags.remove(at: index)
                                            }
                                        } label: {
                                            Label("Delete Tag", systemImage: "trash")
                                        }
                                    } label : {
                                        Text("#\(tag)")
                                            .foregroundColor(.accentColor)
                                            .padding(8)
                                            .background(Color.clear)
                                            .cornerRadius(4)
                                            .contextMenu {
                                            }
                                        
                                    }
                                }
                            }
                            
                        }
                    } else {
                        
                        
                        
                    }
                }
                Section() {
                    Button("Save") {
                        if (whiteboardTitle == "") {
                            isNoTitleAlertShown = true
                        } else {
                            whiteboardManager.whiteboards.append(Whiteboard(title: whiteboardTitle, description: whiteboardDesc, dateCreated: Date(), whiteboardTags: selectedTags, imageData: outputImage.imgData))
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
                TextField("Tag",  text: $tagClass.userInput)
                Button("Cancel", role: .cancel, action: {})
                Button {
                    if tagClass.userInput.isEmpty {
                        
                    } else {
                        selectedTags.append(tagClass.userInput)
                        tagClass.userInput = ""
                    }
                } label: {
                    Text("Add")
                }
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
