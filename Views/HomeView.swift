//
//  HomeView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI

struct HomeView: View {
    
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingImageView = false
    @State private var showingNewWhiteboardView = false
    @State var isDocumentScannerPresented = false
    @ObservedObject var whiteboardManager: WhiteboardManager
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.BackgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView(.vertical) {
                        Menu {
                            // by camera
                            Button {
                                isDocumentScannerPresented = true
                            } label: {
                                Image(systemName: "camera")
                                Text("Camera")
                            }
                            // by importing
                            Menu {
                                
                                
                                
                                // photos
                                Button {
                                    
                                    showingImagePicker = true
                                    
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
                    
                }.navigationTitle("Home")
                
                    .sheet(isPresented: $showingImagePicker) {
                        
                        ImagePicker(image: $inputImage)
                        
                    }
                    .onChange(of: inputImage) { _ in
                        loadImage()
                        showingNewWhiteboardView = true
                    }
                }
            
            .sheet(isPresented: $isDocumentScannerPresented) {
                DocumentCameraView()
            } .onDisappear {
                showingNewWhiteboardView = true
            }
            .sheet(isPresented: $showingNewWhiteboardView) {
                NewWhiteboardView(whiteboards: $whiteboardManager.whiteboards)
            }
        }
    }
    
    func loadImage() {
        
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(whiteboardManager: WhiteboardManager())
    }
}
