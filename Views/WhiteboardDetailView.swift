//
//  WhiteboardDetailView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct WhiteboardDetailView: View {
    
    @Binding var whiteboard: Whiteboard
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                TextField(whiteboard.description, text: $whiteboard.description)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    
            }
        }
        .navigationTitle(Text("\(whiteboard.title)"))
    }
}

//struct WhiteboardDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhiteboardDetailView(whiteboard: .constant(Whiteboard(title: "Test", description: "desc test", dateCreated: Date(), imageData: ["potatoes","funny"])))
//    }
//}
