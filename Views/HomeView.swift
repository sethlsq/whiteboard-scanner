//
//  HomeView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI
import PhotosUI

struct HomeView: View {
    
    @State private var selectedImages: [PhotosPickerItem] = []
    @State private var selectedImageData: [Data] = []
    @ObservedObject var whiteboardManager: WhiteboardManager
    
    @State var outputImage = OutputImage()
    
    //sheet presented
    @State private var isImagePickerPresented = false
    @State private var isNewWhiteboardViewPresented = false
    @State var isDocumentScannerPresented = false
    @State private var isPhotosPickerPresented = false
    //
    
    var body: some View {
        NavigationView {
            VStack {
                Menu {
                    // by camera
                    Button {
                        isDocumentScannerPresented = true
                    } label: {
                        Image(systemName: "camera")
                        Text("Camera")
                    }
                    //by photos
                    Button {
                        print("Photo Picker")
                        isPhotosPickerPresented = true
                        
                    } label: {
                        Image(systemName: "photo")
                        Text("Photos")
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
                
                List() {
                    Section(header: Text("Pinned")) {
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
                        }
                    }
                    Section(header: Text("Recents")) {
                        ForEach($whiteboardManager.whiteboardsSortedEdited) { $whiteboard in
                            let index = whiteboardManager.whiteboardsSortedEdited.firstIndex {
                                $0.id == whiteboard.id
                            } ?? 100
                            
                            if index < 3 {
                                NavigationLink(destination: WhiteboardDetailView(whiteboard: $whiteboard)) {
                                    VStack(alignment: .leading) {
                                        Image(uiImage: UIImage(data: whiteboardManager.whiteboardsSortedEdited[index].imageData[0])!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 256,height: 128)
                                            .cornerRadius(12)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Home")
                .photosPicker(isPresented: $isPhotosPickerPresented, selection: $selectedImages, matching: .images)
                .onChange(of: selectedImages) { newItems in
                    Task {
                        // Retrieve selected asset in the form of Data
                        for newItem in newItems {
                            if let data = try? await newItem.loadTransferable(type: Data.self) {
                                selectedImageData = [data]
//                                var numberOfPages = data.count
                                outputImage.imgData = selectedImageData
                                isNewWhiteboardViewPresented = true
                            }
                        }
                    }
                }
                .fullScreenCover(isPresented: $isNewWhiteboardViewPresented) {
                    NewWhiteboardView(whiteboardManager: whiteboardManager, outputImage: $outputImage, selectedTags: [])
                }
                .fullScreenCover(isPresented: $isDocumentScannerPresented) {
                    DocumentCameraView() { images in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isDocumentScannerPresented = false
                            isNewWhiteboardViewPresented = true
                            outputImage.imgData = images.compactMap { $0.pngData() }
                        }
                    }
                    .background(.black)
                }
            }
        }
    }
}
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(whiteboardManager: WhiteboardManager())
//    }
//}
