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
    @FocusState private var isFocused: Bool
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
                
//                Button {
//
//                    isNewTagAlertShown = true
//
//                } label: {
//
//                    Text("Add Tag")
//                        .padding(10)
//                        .foregroundColor(isEdit ? .accentColor : .clear)
//                        .frame(maxWidth: .infinity)
//                        .cornerRadius(12)
//
//                }
//                .disabled(isEdit ? false : true)
//                .padding(.leading)
//                .padding(.trailing)
//                .alert("Assign Tag", isPresented: $isNewTagAlertShown) {
//                    TextField("Tag",  text: $tagClass.userInput)
//                    Button("Cancel", role: .cancel, action: {})
//                    Button {
//                        if tagClass.userInput.isEmpty {
//
//                        } else {
//                            whiteboard.whiteboardTags.append(tagClass.userInput)
//                            tagClass.userInput = ""
//                        }
//                    } label: {
//                        Text("Add")
//                    }
//                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack (spacing: 10) {
                        
                        ForEach (whiteboard.whiteboardTags, id: \.self) { tag in
                            Button {
                                ////                                whiteboard.whiteboardTags.remove(at: <#T##Int#>)
                                //                                whiteboard.whiteboardTags.remove(id: whiteboard.self)
                            } label: {
                                Text("#\(tag)")
                            }
                            .disabled(isEdit ? false : true)
                            .foregroundColor(isEdit ? .red : .accentColor)
                            .padding(8)
                            .cornerRadius(4)
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
                    .focused($isFocused)
                    .onChange(of: isFocused) { isFocused in
                        whiteboard.description = whiteboardDescription
                    }
                    .padding(.trailing)
                    .padding(.leading)
                    .textFieldStyle(.roundedBorder)
                    .disabled(isEdit)
                
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
        .onAppear() {
            whiteboard.dateCreatedString = Date.now.formatted(date: .long, time: .shortened)
            whiteboard.dateCreated = Date.now
            whiteboardDescription = whiteboard.description
        }
    }
}

//struct WhiteboardDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhiteboardDetailView(whiteboard: .constant(Whiteboard(title: "Test", description: "desc test", dateCreated: Date(), imageData: ["potatoes","funny"])))
//    }
//}
