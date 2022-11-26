//
//  WhiteboardDetailView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct WhiteboardDetailView: View {
    
    @Binding var whiteboard: Whiteboard
    @State var isCurrentlyPinned: Bool = true
    @State var isEdit = true
    @State var whiteboardDescription: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Image(uiImage: UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
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
            
            Toggle("Pin?", isOn: $isCurrentlyPinned)
                .onChange(of: isCurrentlyPinned) { isCurrentlyPinned in
                    
                    whiteboard.isPinned = isCurrentlyPinned
                    
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
            
            isCurrentlyPinned = whiteboard.isPinned
            
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
