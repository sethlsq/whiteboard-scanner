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
            HStack() {
                Button {
                    print("button")
                } label: {
                    Label("Scan", systemImage: "doc.viewfinder")
                }
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
