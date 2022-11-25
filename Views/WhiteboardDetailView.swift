//
//  WhiteboardDetailView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct WhiteboardDetailView: View {
    
    @Binding var whiteboard: Whiteboard
    @State var isEdit = true
    @State var whiteboardDescription: String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Image(uiImage: UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                TextField("Description" ,text: $whiteboardDescription, axis: .vertical
                )
                .onSubmit {
                    whiteboard.description = whiteboardDescription
                }
                    .lineLimit(1...10)
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
            whiteboardDescription = whiteboard.description
        }
    }
}

//struct WhiteboardDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhiteboardDetailView(whiteboard: .constant(Whiteboard(title: "Test", description: "desc test", dateCreated: Date(), imageData: ["potatoes","funny"])))
//    }
//}
