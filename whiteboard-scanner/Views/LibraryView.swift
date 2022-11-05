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
            ScrollView {
                Text("hello")
            }
            .navigationTitle("Whiteboards")
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
