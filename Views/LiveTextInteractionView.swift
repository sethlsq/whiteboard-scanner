//
//  LiveTextInteractionView.swift
//  whiteboard-scanner
//
//  Created by Alina Fu on 27/11/65 BE.
//

import SwiftUI

struct LiveTextInteractionView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            LiveTextView(imageName: "Image")

                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
                .interactiveDismissDisabled(true)
        }
    }
}

struct LiveTextInteractionView_Previews: PreviewProvider {
    static var previews: some View {
        LiveTextInteractionView()
    }
}
