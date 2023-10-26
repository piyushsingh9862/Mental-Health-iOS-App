//
//  CardView.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 24/10/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @State private var isShareSheetPresented = false
    @State private var isSelectorPresented = false
    @State private var isExternalWebViewPresented = false
  
    @ObservedObject var cardViewModel: CardViewModel

    var body: some View {
        VStack {
            
            if cardViewModel.isLoading {
               
                RemoteImage(url: cardViewModel.placeholderImageURL)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
            }
            else {
                
                
                // Display the card's title
                HStack{
                    Text(card.themeTitle.uppercased())
                        .font(.title3)
                        .padding(.top, 10)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    
                Spacer()
                    
                }
                Spacer()
                Spacer()
               
                // Display the card's image
                RemoteImage(url: card.dzImageUrl)
                    .scaledToFill()
                    .frame(height: 340)
                    .clipped()

                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    
                    if !card.articleUrl.isEmpty {
                        Button(action: {
                            
                            
                            isExternalWebViewPresented = true // Show the ExternalWebView
                            
                            
                        }) {
                            HStack {
                                Image(systemName: "doc.text")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.gray)
                                
                                Text("Read Full Post")
                                   
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 30)
                                .fill(Color(white: 0.9))
                            )

                            
                            
                        }
                        
                        .overlay(
                            NavigationLink("", destination: ExternalWebView(url: card.articleUrl), isActive: $isExternalWebViewPresented)
                        )
                    }
                    
                    Button(action: {
                        // Handle Share action
                        isShareSheetPresented = true // Show the ShareView
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.gray)
                            .cornerRadius(30)
                    }
                    .sheet(isPresented: $isShareSheetPresented) {
                        ShareView(card: card, isShareSheetPresented: $isShareSheetPresented, isSelectorPresented: $isSelectorPresented)
                            .presentationDetents([.height(600)])
                    }
                    
                    Button(action: {
                      // handle Bookmark
                    }) {
                        Image(systemName: "bookmark")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.gray)
                            .cornerRadius(30)
                    }
                    
                 
                   
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
        }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    
    
    func shareCard(card: Card) {
        // Construct the text to share
        let shareText = "\(card.themeTitle)\n\(card.text) - \(card.author)"
        
       
        var items: [Any] = [shareText]
        
        // Check if the card has an image URL and load the image
        if let imageURL = URL(string: card.dzImageUrl),
           let imageData = try? Data(contentsOf: imageURL),
           let image = UIImage(data: imageData) {
            items.append(image)
        }
        
        // Create a UIActivityViewController
        let activityViewController = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        
       
        let excludedActivities: [UIActivity.ActivityType] = [
            .addToReadingList, .airDrop, .assignToContact, .markupAsPDF,
            .openInIBooks, .postToTencentWeibo, .postToVimeo, .print, .saveToCameraRoll
        ]
        
        activityViewController.excludedActivityTypes = excludedActivities
        
        // Present the share sheet
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
        // Copy text to clipboard
        let pasteboard = UIPasteboard.general
        pasteboard.string = shareText
    }

}
