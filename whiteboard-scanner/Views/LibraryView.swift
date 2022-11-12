//
//  LibraryView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.BackgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack {
                        
                        Text("PINNED")
                            .foregroundColor(.SubheadingColor)
                            .font(.system(size:12))
                            .frame(width:80)
                        
                        Spacer()
                        
                    }
                
                    // Pinned VStack
                    
                    
                        
                        VStack {
                            
                            HStack {
                                
                                Spacer()
                                Spacer()
                                
                                GeometryReader { context in
                                    
                                    Button {
                                        
                                        
                                        
                                    } label: {
                                        
                                        
                                        
                                    }.frame(maxWidth: context.size.width)
                                        .padding(40)
                                        .background(.black)
                                        .cornerRadius(13)
                                    
                                    
                                }
                                
                                Spacer()
                                Spacer()
                            }
                        }
                    
                    
                }
                
            }
            .navigationTitle("Library")
            
            
        }
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
