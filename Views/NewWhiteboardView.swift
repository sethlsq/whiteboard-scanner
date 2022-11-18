//
//  WhiteboardDetailView.swift
//  whiteboard-scanner
//
//  Created by T Krobot on 18/11/22.
//

import SwiftUI

struct NewWhiteboardView: View {
    
    @Binding var whiteboard: Whiteboard
    
    @AppStorage ("note") var note = ""
    var image: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        
   
            
        ZStack {
            
            Color.BackgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                //Potato
                ZStack {
                    
                    
                    Image("funny")
                        .resizable()
                        .padding()
                        .scaledToFit()
                    
                    //                        Button {
                    //
                    //                            loadImage()
                    //
                    //                        } label: {
                    //
                    //                            Image(systemName: "pencil")
                    //                                .foregroundColor(.white)
                    //                                .padding()
                    //                                .background(.blue)
                    //                                .frame(maxWidth: 40, maxHeight: 40)
                    //                                .cornerRadius(70)
                    //                                .font(.system(size:30))
                    //                                .offset(x:145, y:97)
                    //
                    //
                    //
                    //                        }
                    
                }
                
                Spacer()
                
                // Description TextField
                VStack {
                    TextField("Title", text: $whiteboard.title, axis: .vertical)
                        .lineLimit(1...5)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                    
                    TextField("Description", text: $whiteboard.description, axis: .vertical)
                        .lineLimit(2...5)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                    
                    
                    Spacer()
                    
                }
                .padding()
                Button {
                    guard let inputImage = inputImage else {return}
                    let imageSaver = ImageSaver()
                    imageSaver.writeToPhotoAlbum(image: inputImage)
                } label: {
                    HStack() {
                        Image(systemName: "square.and.arrow.up")
                        Text("Export")
                    }
                    .bold()
                    .padding(10)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
            
        
        
    }
    
//    func loadImage() {
//
//        guard let inputImage = inputImage else { return }
//
//        image = Image(uiImage: inputImage)
//
//    }
    
}

struct NewWhiteboardView_Previews: PreviewProvider {
    static var previews: some View {
        NewWhiteboardView(whiteboard: .constant(Whiteboard()))
    }
}
