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
            ScrollView(.vertical) {
               Text("test test test")
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
