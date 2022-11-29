//
//  WhiteboardDetailView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI
import QuickLook

struct WhiteboardDetailView: View {
    
    @Binding var whiteboard: Whiteboard
    @State var isEdit = false
    @State var isNewTagAlertShown = false
    @ObservedObject var tagClass = TagClass()
    @State var whiteboardDescription: String = ""
    @State var whiteboardTitle: String = ""
    @FocusState private var isFocusedDescription: Bool
    @State var url: URL?
    
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Button {
                    url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(whiteboard.title).png", conformingTo: .image)
                    if let url {
                        let pngData = UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])?.pngData()
                        do {
                            try pngData?.write(to: url)
                        } catch {
                            print("Failed to write PNG data")
                        }
                    }
                } label: {
                    Image(uiImage: UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 384)
                        .padding()
                }
                .quickLookPreview($url)
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack (spacing: 10) {
                        
                        ForEach (whiteboard.whiteboardTags, id: \.self) { tag in
                            Menu {
                                Button(role: .destructive) {
                                    if let index = whiteboard.whiteboardTags.firstIndex(of: tag) {
                                        whiteboard.whiteboardTags.remove(at: index)
                                    }
                                } label: {
                                    Label("Delete Tag", systemImage: "trash")
                                }
                            } label: {
                                Text("#\(tag)")
                                    .foregroundColor(isEdit ? .red : .accentColor)
                                    .padding(8)
                                    .disabled(!isEdit)
                                    .cornerRadius(4)
                                
                            }
                            .disabled(!isEdit)
                        }
                        
                        Button {
                            
                            isNewTagAlertShown = true
                            
                        } label: {
                            
                            Text("Add Tag")
                                .padding(10)
                                .foregroundColor(isEdit ? .accentColor : .clear)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                            
                        }
                        .disabled(isEdit ? false : true)
                        .padding(.trailing)
                        .alert("Assign Tag", isPresented: $isNewTagAlertShown) {
                            TextField("Tag",  text: $tagClass.userInput)
                            Button("Cancel", role: .cancel, action: {})
                            Button {
                                if tagClass.userInput.isEmpty {
                                    
                                } else {
                                    whiteboard.whiteboardTags.append(tagClass.userInput)
                                    tagClass.userInput = ""
                                }
                            } label: {
                                Text("Add")
                            }
                        }
                        
                    }.padding(.leading)
                    
                    
                }
                
                TextField("Description", text: $whiteboardDescription, axis:.vertical)
                    .focused($isFocusedDescription)
                    .onChange(of: isFocusedDescription) { isFocusedDecription in
                        whiteboard.description = whiteboardDescription
                    }
                    .padding(.trailing)
                    .padding(.leading)
                    .textFieldStyle(.roundedBorder)
                    .disabled(!isEdit)
                
                Text("\(whiteboard.dateCreatedString)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEdit = !isEdit
                } label: {
                    Text(isEdit ? "Done" : "Edit")
                }
            }
        }
        .navigationBarTitleDisplayMode(isEdit ? .inline: .large)
        .navigationTitle($whiteboard.title)
        //        .toolbar {
        //            ToolbarItem(placement: .principal) {
        //                TextField("Title", text: $whiteboardTitle)
        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
        //                    .onChange(of: whiteboardTitle) { isFocusedTitle in
        //                        whiteboard.title = whiteboardTitle
        //                    }
        //                    .opacity(isEdit ? 100 : 0)
        //            }
        //        }
        .onAppear {
//            whiteboard.dateCreatedString = Date.now.formatted(date: .long, time: .shortened)
            whiteboard.dateCreated = Date.now
            //            whiteboardTitle = whiteboard.title
            whiteboardDescription = whiteboard.description
        }
    }
}

//struct WhiteboardDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhiteboardDetailView(whiteboard: .constant(Whiteboard(title: "Test", description: "desc test", dateCreated: Date(), imageData: ["potatoes","funny"])))
//    }
//}
