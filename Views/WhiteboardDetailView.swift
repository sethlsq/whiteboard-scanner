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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                TextField(whiteboard.description, text: $whiteboard.description, axis: .vertical)
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
                    whiteboard.description = whiteboard.description
                    whiteboard.title = whiteboard.title
                } label: {
                    Text(isEdit ? "Edit" : "Done")
                }
            }
        }
        .navigationBarTitleDisplayMode(isEdit ? .large: .inline)
        .navigationTitle($whiteboard.title)
        .onAppear() {
            
            isCurrentlyPinned = whiteboard.isPinned
            
        }
    }
}

//struct WhiteboardDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhiteboardDetailView(whiteboard: .constant(Whiteboard(title: "Test", description: "desc test", dateCreated: Date(), imageData: ["potatoes","funny"])))
//    }
//}
