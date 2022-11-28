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
    
//    var tagFilteredWhiteboards: [Whiteboard] {
//        if let userSelectedTag = userSelectedTag {
//            return whiteboardManager.whiteboards.filter { (whiteboard) -> Bool in
//                whiteboard.whiteboardTags.contains(userSelectedTag)
//            }
//        }
//        return whiteboardManager.whiteboards
//    }
 
    var body: some View {
        NavigationView() {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        Button {
                            whiteboardManager.filterString = ""
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
                                whiteboardManager.filterString = tag
                                whiteboardManager.hasSorted = 3
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
                
                List() {
                    Section (header: Text("PINNED")) {
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
//    func whatarray() -> Binding<[Whiteboard]>  {
//        switch whiteboardManager.hasSorted {
//        case 1: return $whiteboardManager.whiteboardsSortedDate
//        case 2: return $whiteboardManager.whiteboardsSortedName
//        case 3: return $whiteboardManager.tagFilteredWhiteboards(filterString: whiteboardManager.filterString)
//        default : return $whiteboardManager.sortedWhiteboards
//        }
//    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(whiteboardManager: WhiteboardManager())
    }
}

