//
//  LibraryView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct LibraryView: View {
    
    @ObservedObject var whiteboardManager: WhiteboardManager
    @State var whiteboardsort: [Whiteboard] = []
    
    var body: some View {
        NavigationView() {
            List {
                ForEach($whiteboardManager.sortedWhiteboards) { $whiteboard in
                    NavigationLink(destination: WhiteboardDetailView(whiteboard: $whiteboard)) {
                        HStack {
                            Image(uiImage: UIImage(data: whiteboard.imageData[0])!)
                                .resizable()
                                .frame(width: 64.0, height: 48.0)
                                .cornerRadius(4)
                            
                            VStack(alignment: .leading) {
                                Text(whiteboard.title)
                                Text("\(whiteboard.dateCreatedString)")
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
            }
            .navigationTitle("Whiteboards")
            .searchable(text: $whiteboardManager.searchTerm)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                //                ToolbarItem(placement: .navigationBarTrailing) {
                //                    Menu {
                //                        Button {
                //                            whiteboardsort = whiteboardsSortedDate
                //                            hasSorted = true
                //                        } label: {
                //                            Text("Sort by Date")
                //                        }
                //                        Button {
                //                            whiteboardsort = whiteboardsSortedName
                //                            hasSorted = true
                //                        } label: {
                //                            Text("Sort by Name")
                //                        }
                //                    } label: {
                //                        Image(systemName: "ellipsis.circle")
                //                    }
                //                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(whiteboardManager: WhiteboardManager())
    }
}

