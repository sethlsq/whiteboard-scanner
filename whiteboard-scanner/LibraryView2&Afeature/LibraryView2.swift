//
//  LibraryView2.swift
//  whiteboard-scanner
//
//  Created by Alina Fu on 15/11/65 BE.

import SwiftUI

struct Folder: Identifiable {
    
    let id = UUID()
    
    var name: String
}

struct LibraryView2: View {
    
    @State var folders = [Folder(name: "History"),
                          Folder(name: "Science"),
                          Folder(name: "Math"),
                          Folder(name: "English")]
    
    @State var isSheetPresented = false
    
    var body: some View {

        NavigationView{
            List{
                ForEach($folders) { $folder in
                    NavigationLink {
                        LibraryDetail(folder: $folder)
                        
                    } label: {
                        Text(folder.name)
                    }
                    .navigationTitle("Library")
                }
                .onDelete { indexSet in
                    folders.remove(atOffsets: indexSet)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSheetPresented = true
                    } label : {
                        Image(systemName: "plus")
                    }
                    
                }
                }
            .sheet(isPresented: $isSheetPresented) {
                NewFolder(folders: $folders)
            }
                }
    
            }
            }


        
        struct LibraryView2_Previews: PreviewProvider {
            static var previews: some View {
                LibraryView2()
            }
        }
