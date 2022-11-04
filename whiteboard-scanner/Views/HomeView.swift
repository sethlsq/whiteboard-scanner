//
//  HomeView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI

struct HomeView: View {
    
    // new scan functions
    func importByCamera() {
        
    }
    func importByPhotos() {
        
    }
    func importByFiles() {
        
    }
    
    var body: some View {
        NavigationView {
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
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
