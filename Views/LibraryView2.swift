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

struct Folder2: Identifiable{
    let  id = UUID()
    
    var name2: String
}

struct Folder3: Identifiable{
    let id = UUID()
    
    var name3: String
}

struct LibraryView2: View {
    
    @State var folders = [Folder(name: "History"),
                          Folder(name: "Geography")]
    
    @State var folders2 = [Folder2(name2: "Physics"),
                           Folder2(name2: "Biology"),
                           Folder2(name2:
                                    "Chemistry"),
    ]
    
    @State var folders3 = [Folder3(name3: "Math"),
                           Folder3(name3: "English")]
    
    
    @State var isSheetPresented = false
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                
                Color.BackgroundColor.edgesIgnoringSafeArea(.all)
                
                Form {
                    
                    // Pinned
                    Section (header: Text("PINNED")) {
                        
                        List{
                            ForEach($folders) { $folder in
                                NavigationLink {
                                    SamplePinnedView()
                                    
                                } label: {
                                    Text(folder.name)
                                    
                                }
                                .navigationTitle("Library")
                            }
                            
                            .onDelete { indexSet in
                                folders.remove(atOffsets: indexSet)
                            }
                            .onMove { indices, newOffset in
                                folders.move(fromOffsets: indices, toOffset: newOffset)
                            }
                            
                            
                        }
                        
                        
                    }
                    Section (header: Text("RECENTS")) {
                        List{
                            ForEach($folders2) { $folder2 in
                                NavigationLink {
                                    SamplePinnedView()
                                    
                                } label: {
                                    Text(folder2.name2)
                                }
                            }
                            .onDelete { indexSet in
                                folders2.remove(atOffsets: indexSet)
                            }
                            .onMove { indices, newOffset in
                                folders.move(fromOffsets: indices, toOffset: newOffset)
                            }
                            
                            
                        }
                    }
                    Section (header: Text("ALL")) {
                        
                        List{
                            ForEach($folders3) { $folder3 in
                                NavigationLink {
                                    SamplePinnedView()
                                    
                                } label: {
                                    Text(folder3.name3)
                                }
                            }
                            .onDelete { indexSet in
                                folders3.remove(atOffsets: indexSet)
                                
                            }
                            .onMove { indices, newOffset in
                                folders.move(fromOffsets: indices, toOffset: newOffset)
                            }
                            
                        }
                    }
                    
                    
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        isSheetPresented = true
                    } label : {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        NewFolder(folders: $folders)
                    }
        }
       
                
            }
        }
    }
}
    
    
    
    
    
    struct LibraryView2_Previews: PreviewProvider {
        static var previews: some View {
            LibraryView2()
        }
    }
