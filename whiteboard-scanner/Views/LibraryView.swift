
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
                
                Form {
                    
                    // Pinned
                    Section (header: Text("PINNED")) {
                        
                        NavigationLink("Trigonometry Graphs", destination: SamplePinnedView())
                        NavigationLink("English", destination: SamplePinnedView())
                            
                        }
                        
                    
                    
                    // All
                    Section (header: Text("ALL")) {
                        
                        NavigationLink("Physics", destination: SamplePinnedView())
                        
                    }
                    
                }
                
            }.navigationTitle("Library")

            
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
