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
    @State var showAlertNoTitle = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ScrollView(.horizontal) {
                        Image(uiImage: UIImage(data: outputImage.imgData[outputImage.imgData.count - 1])!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 128, height: 128)
                            .cornerRadius(12)
                            .padding()
                    }
                }
                Section(header: Text("options")) {
                    TextField("Title", text: $whiteboardTitle)
                        .frame(width: .infinity)
                    TextField("Description", text: $whiteboardDesc, axis: .vertical)
                        .frame(width: .infinity)
                }
                Section() {
                    Button("Save") {
                        if (whiteboardTitle == "") {
                            showAlertNoTitle = true
                        } else {
                            whiteboardManager.whiteboards.append(Whiteboard(title: whiteboardTitle, description: whiteboardDesc, dateCreatedString: Date.now.formatted(date: .long, time: .shortened), dateCreated: Date(), imageData: outputImage.imgData))
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                }
                
            }
            .navigationTitle("New Whiteboard")
            .alert("Please enter a title", isPresented: $showAlertNoTitle) {
                Button(role: .none) {
                    showAlertNoTitle = false
                } label: {
                    Text("Continue")
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
