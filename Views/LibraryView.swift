//
//  LibraryView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct LibraryView: View {
    
    @ObservedObject var whiteboardManager: WhiteboardManager
    @State private var searchText = ""
    @State var isCurrentlyPinned: Bool = true
    @State var whiteboardsort: [Whiteboard] = []
    
    @State private var userSelectedTag: String? = nil
    
    var allTags: [String] {
        var tags: Set<String> = []
        for whiteboard in whiteboardManager.whiteboards {
            for tag in whiteboard.whiteboardTags {
                tags.insert(tag)
            }
        }
        return Array(tags)
    }
    
    var filteredWhiteboards: [Whiteboard] {
        if let userSelectedTag = userSelectedTag {
            return whiteboardManager.whiteboards.filter { (whiteboard) -> Bool in
                whiteboard.whiteboardTags.contains(userSelectedTag)
            }
        }
        return whiteboardManager.whiteboards
    }
 
    var body: some View {
        NavigationView() {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        Button {
                           userSelectedTag = nil
                        } label: {
                            Text("All")
                        }
                        ForEach (allTags, id: \.self) { tag in
                            Button {
                                userSelectedTag = tag
                            } label: {
                                Text("#\(tag)")
                            }
                        }
                    }
                }
                
                List {
                    Section (header: Text("PINNED")) {
                        
                        ForEach($whiteboardManager.sortedWhiteboards.filter { $0.wrappedValue.isPinned }) { $whiteboard in
                            
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
                            .swipeActions(edge: .leading) {
                                Button {
                                    
                                    whiteboard.isPinned = !isCurrentlyPinned
                                    
                                } label: {
                                    Image(systemName: "pin.slash.fill")
                                }
                            }
                        }
                        
                        .onDelete { indexSet in
                            whiteboardManager.whiteboards.remove(atOffsets: indexSet)
                        }
                        .onMove { indices, newOffset in
                            whiteboardManager.whiteboards.move(fromOffsets: indices, toOffset: newOffset)
                        }
                        //                    .swipeActions(edge: .leading) {
                        //                        Button {
                        //
                        //                            whiteboardManager.whiteboard.isPinned = isCurrentlyPinned
                        //
                        //
                        //                        } label: {
                        //                            Image(systemName: "pin.slash.fill")
                        //                        }
                        //                    }
                        
                    }
                    
                    
                    
                    Section (header: Text("ALL")) {
                        
                        ForEach($whiteboardManager.sortedWhiteboards.filter { $0.wrappedValue.isPinned == false}) { $whiteboard in
                            
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
                            }.swipeActions(edge: .leading) {
                                Button {
                                    
                                    whiteboard.isPinned = isCurrentlyPinned
                                    
                                } label: {
                                    Image(systemName: "pin.fill")
                                }
                            }
                        }
                        .onDelete { indexSet in
                            whiteboardManager.whiteboards.remove(atOffsets: indexSet)
                        }
                        .onMove { indices, newOffset in
                            whiteboardManager.whiteboards.move(fromOffsets: indices, toOffset: newOffset)
                        }
                        //                    .swipeActions(edge: .leading) {
                        //                        Button {
                        //
                        //                        } label: {
                        //                            Image(systemName: "pin.fill")
                        //                        }
                        //                    }
                    }
                }
                .navigationTitle("Whiteboards")
                .searchable(text: $whiteboardManager.searchTerm)
                .onSubmit(of: .search, {
                    whiteboardManager.hasSorted = 0
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button {
                                whiteboardManager.hasSorted = 1
                            } label: {
                                Image(systemName: "calendar")
                                Text("Sort by Date")
                            }
                            Button {
                                whiteboardManager.hasSorted = 2
                            } label: {
                                Image(systemName: "textformat")
                                Text("Sort by Name")
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
            }
        }
    }
    func whatarray() -> Binding<[Whiteboard]>  {
        switch whiteboardManager.hasSorted {
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

