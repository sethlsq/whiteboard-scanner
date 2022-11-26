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
    @State var hasSorted: Int = 0
    
    var body: some View {
        NavigationView() {
            List {
                ForEach(whatarray()) { $whiteboard in
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
            .onSubmit(of: .search, {
                hasSorted = 0
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            hasSorted = 1
                        } label: {
                            Text("Sort by Date")
                        }
                        Button {
                            hasSorted = 2
                        } label: {
                            Text("Sort by Name")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
    func whatarray() -> Binding<[Whiteboard]>  {
        switch hasSorted {
        case 1: return $whiteboardManager.whiteboardsSortedDate
        case 2: return $whiteboardManager.whiteboardsSortedName
        default : return $whiteboardManager.sortedWhiteboards
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(whiteboardManager: WhiteboardManager())
    }
}

