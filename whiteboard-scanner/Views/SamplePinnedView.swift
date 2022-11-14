//
//  SamplePinnedView.swift
//  whiteboard-scanner
//
//  Created by T Krobot on 13/11/22.
//

import SwiftUI

struct SamplePinnedView: View {
    
    @AppStorage ("note") var note = ""
    
    var body: some View {
        
   
            
            ZStack {
                
                Color.BackgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    //Potato
                    ZStack {
                        
                        Image("potatoes")
                            .resizable()
                            .padding()
                            .scaledToFit()
                        
                        Button {
                            
                            
                            
                        } label: {
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .padding()
                                .background(.blue)
                                .frame(maxWidth: 40, maxHeight: 40)
                                .cornerRadius(70)
                                .font(.system(size:30))
                                .offset(x:145, y:97)
                            
                            
                            
                        }
                        
                    }
                        
                    Spacer()
                    
                    // Description TextField
                    VStack {
                        
                        TextField("Description", text:$note, axis: .vertical)
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                        
                        
                        Spacer()
                        
                    }
                    .padding()
                }
                
            }.navigationTitle("Potato")
            
            
        
        
    }
}

struct SamplePinnedView_Previews: PreviewProvider {
    static var previews: some View {
        SamplePinnedView()
    }
}
