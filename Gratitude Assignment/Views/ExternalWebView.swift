//
//  ExternalWebView.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 26/10/23.
//

import SwiftUI
import SafariServices

struct ExternalWebView: UIViewControllerRepresentable {
    let url: String

    func makeUIViewController(context: Context) -> SFSafariViewController {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL")
        }
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}


