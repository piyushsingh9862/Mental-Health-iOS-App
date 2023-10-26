//
//  RemoteImage.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 24/10/23.
//

import SwiftUI

struct RemoteImage: View {
    private let url: String

    init(url: String) {
        self.url = url
    }

    var body: some View {
        if let url = URL(string: url) {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    
                } else {
                    // Display a loading placeholder here
                    Image("Placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    ProgressView()
                }
            }
        } else {
            
            Text("Invalid URL")
        }
    }
}

