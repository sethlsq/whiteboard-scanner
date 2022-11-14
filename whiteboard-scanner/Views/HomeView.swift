//
//  HomeView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI

struct HomeView: View {    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.BackgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView(.vertical) {
                        Menu {
                            // by camera
                            Button {
                                importByCamera()
                            } label: {
                                Image(systemName: "camera")
                                Text("Camera")
                            }
                            // by importing
                            Menu {
                                
                                
                                
                                // photos
                                Button {
                                    importByPhotos()
                                } label: {
                                    Image(systemName: "photo")
                                    Text("Photos")
                                }
                                
                                
                                
                                //files
                                Button {
                                    importByFiles()
                                } label: {
                                    Image(systemName: "folder")
                                    Text("Files")
                                }
                            } label: {
                                Image(systemName: "square.and.arrow.down")
                                Text("Import")
                            }
                            
                        } label: {
                            HStack() {
                                Image(systemName: "doc.viewfinder")
                                Text("New Scan")
                            }
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    Form {
                        Section (header: Text("Recents")) {
                            NavigationLink("Trigonometry Graphs", destination: SamplePinnedView())
                        }
                        Section (header: Text("PINNED")) {
                            NavigationLink("Trigonometry Graphs", destination: SamplePinnedView())
                            NavigationLink("English", destination: SamplePinnedView())
                        }
                    }
                }.navigationTitle("Home")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
