//
//  LibraryView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct LibraryView: View {
    
    @StateObject var whiteboardManager = WhiteboardManager()
    
    var body: some View {
        NavigationView() {
            List {
                ForEach($whiteboardManager.whiteboards) { $whiteboard in
                    NavigationLink(destination: WhiteboardDetailView(whiteboard: $whiteboard)) {
                        HStack {
                            Image(uiImage: UIImage(data: whiteboard.imageData[0])!)
                                .resizable()
                                .frame(width: 64.0, height: 48.0)
                                .cornerRadius(4)

                            VStack(alignment: .leading) {
                                Text(whiteboard.title)
                                Text("\(whiteboard.dateCreated)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    whiteboardManager.whiteboards.remove(atOffsets: indexSet)
                }
                .onMove { indices, newOffset in
                    whiteboardManager.whiteboards.move(fromOffsets: indices, toOffset: newOffset)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
            }
            .navigationTitle("Whiteboards")
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
