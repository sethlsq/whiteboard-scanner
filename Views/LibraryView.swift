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
    
    var allTags: [String] {
        var tags: Set<String> = []
        for whiteboard in whiteboardManager.whiteboards {
            for tag in whiteboard.whiteboardTags {
                tags.insert(tag)
            }
        }
        
        return tags.sorted()
    }
    
    var body: some View {
        // NavigationStack {
        NavigationView() {
            VStack {
                List() {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Button {
                                withAnimation(.linear(duration: 0.25)) {
                                    whiteboardManager.filterString = ""
                                }
                            } label: {
                                Text("All")
                            }
                            .foregroundColor(whiteboardManager.filterString.isEmpty ? .white : .accentColor)
                            .padding(8)
                            .background(whiteboardManager.filterString.isEmpty ? Color.accentColor : Color.clear)
                            .cornerRadius(4)
                            .padding(.leading)
                            
                            ForEach (allTags, id: \.self) { tag in
                                Button {
                                    withAnimation(.linear) {
                                        whiteboardManager.filterString = tag
                                        whiteboardManager.hasSorted = 3
                                    }
                                } label: {
                                    Text("#\(tag)")
                                }
                                .foregroundColor(whiteboardManager.filterString == tag ? .white : .accentColor)
                                .padding(8)
                                .background(whiteboardManager.filterString == tag ? Color.accentColor : Color.clear)
                                .cornerRadius(4)
                            }
                            .padding(.trailing)
                        }
                    }
                    .padding(.horizontal, -21)
                    .listRowBackground(Color.clear)
                    
                    Section (header: Text("Pinned")) {
                        ForEach($whiteboardManager.sortedWhiteboards) { $whiteboard in
                            if whiteboard.isPinned {
                                NavigationLink(destination: WhiteboardDetailView(whiteboard: $whiteboard)) {
                                    
                                    HStack {
                                        Image(uiImage: UIImage(data: whiteboard.imageData[0])!)
                                            .resizable()
                                            .frame(width: 64.0, height: 48.0)
                                            .cornerRadius(4)
                                        
                                        VStack(alignment: .leading) {
                                            Text(whiteboard.title)
                                            Text(whiteboardManager.hasSorted == 4 ? "\(whiteboard.dateEditedString)" : "\(whiteboard.dateCreatedString)")
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
                        }
                        .onDelete { indexSet in
                            let index = indexSet.first!
                            let whiteboardToDelete = whiteboardManager.sortedWhiteboards[index]
                            
                            if let whiteboardIndex = whiteboardManager.whiteboards.firstIndex { $0.id == whiteboardToDelete.id } {
                                whiteboardManager.whiteboards.remove(at: whiteboardIndex)
                            }
                        }
                        //                        .onMove { indices, newOffset in
                        //                            whiteboardManager.whiteboards.move(fromOffsets: indices, toOffset: newOffset)
                        //                        }
                    }
                    Section (header: Text("Whiteboards")) {
                        
                        ForEach($whiteboardManager.sortedWhiteboards) { $whiteboard in
                            if !whiteboard.isPinned {
                                NavigationLink(destination: WhiteboardDetailView(whiteboard: $whiteboard)) {
                                    
                                    HStack {
                                        Image(uiImage: UIImage(data: whiteboard.imageData[0])!)
                                            .resizable()
                                            .frame(width: 64.0, height: 48.0)
                                            .cornerRadius(4)
                                        
                                        VStack(alignment: .leading) {
                                            Text(whiteboard.title)
                                            Text(whiteboardManager.hasSorted == 1 ? "\(whiteboard.dateCreatedString)" : "\(whiteboard.dateEditedString)")
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
                        }
                        .onDelete { indexSet in
                            let index = indexSet.first!
                            let whiteboardToDelete = whiteboardManager.sortedWhiteboards[index]
                            if let whiteboardIndex = whiteboardManager.whiteboards.firstIndex { $0.id == whiteboardToDelete.id } {
                                whiteboardManager.whiteboards.remove(at: whiteboardIndex)
                            }
                        }
                        //                        .onMove { indices, newOffset in
                        //                            whiteboardManager.whiteboards.move(fromOffsets: indices, toOffset: newOffset)
                        //                        }
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
                                Text("Sort by Date Created")
                            }
                            Button {
                                whiteboardManager.hasSorted = 4
                            } label: {
                                Image(systemName: "pencil.circle")
                                Text("Sort by Date Edited")
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
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(whiteboardManager: WhiteboardManager())
    }
}

