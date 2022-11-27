//
//  WhiteboardDetailView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//



import SwiftUI
import VisionKit
    
struct WhiteboardDetailView: View {
    
    @Binding var whiteboard: Whiteboard
    @State var isEdit = true
    @State var whiteboardDescription: String = ""
    @FocusState private var isFocused: Bool
    @State private var deviceSupportLiveText = false
    @State private var showDeviceNotCapacityAlert = false
    @State private var showLiveTextView = false
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Image(uiImage: UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                Button {
                    if deviceSupportLiveText {
                        self.showLiveTextView = true
                    } else {
                        self.showDeviceNotCapacityAlert = true
                    }
                } label: {
                    Text("Live text")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert("Live Text Unavailable", isPresented: $showDeviceNotCapacityAlert, actions: {})
                .sheet(isPresented: $showLiveTextView, content: {
                    LiveTextInteractionView()
                })
                .onAppear {
                    self.deviceSupportLiveText = ImageAnalyzer.isSupported
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
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEdit = !isEdit
                } label: {
                    Text(isEdit ? "Edit" : "Done")
                }
            }
        }
        .navigationBarTitleDisplayMode(isEdit ? .large: .inline)
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
