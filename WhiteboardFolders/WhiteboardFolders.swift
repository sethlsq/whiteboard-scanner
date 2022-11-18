//
//  WhiteboardFolders.swift
//  whiteboard-scanner
//
//  Created by T Krobot on 18/11/22.
//

import SwiftUI


struct WhiteboardFolders: View {
    
    struct WhiteboardFolder: Identifiable {
        
        let id = UUID()
        
        var name: String
    }
    
    @State var WhiteboardFolders = [WhiteboardFolder(name: "History"),
                                    WhiteboardFolder(name: "Science"),
                                    WhiteboardFolder(name: "English")]
    
    @State var isSheet2Presented = false
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach($WhiteboardFolders) { $WhiteboardFolder in
                    NavigationLink {
                        WhireboardFolderDetail(WhiteboardFolder: $WhiteboardFolder)
                        
                    } label: {
                        Text(WhiteboardFolder.name)
                    }
                    .navigationTitle("Library")
                }
                .onDelete { indexSet in
                    WhiteboardFolders.remove(atOffsets: indexSet)
                }
            }
            .toolbar
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isSheet2Presented = true
                } label : {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isSheet2Presented) {
            NewWhiteboardFolder(WhiteboardFolders: $WhiteboardFolders)
        }
    }
}



struct WhiteboardFolders_Previews: PreviewProvider {
    static var previews: some View {
        WhiteboardFolders()
    }
}
