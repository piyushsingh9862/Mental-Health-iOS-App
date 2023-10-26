//
//  ShareActivityViewController.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 26/10/23.
//

import SwiftUI
import UIKit

struct ShareActivityViewController: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
       
    }
}
