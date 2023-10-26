//
//  ShareScreen.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 25/10/23.
//

import SwiftUI

struct ShareView: View {
    let card: Card
    @Binding var isShareSheetPresented: Bool
    @Binding var isSelectorPresented: Bool


    var body: some View {
        VStack {
            HStack{
                Text("Inspire Your Friends")
                    .font(.title2)
                    .bold()
                    .padding()
                
                
                Spacer()
                
                Button(action: {
                                      // Close the ShareView
                                      isShareSheetPresented = false
                                  }) {
                                      Image(systemName: "xmark")
                                       .padding(10)
                                          .background(Circle().fill(Color.gray.opacity(0.4)))
                                          .foregroundColor(.gray)
                                  }
                              }
            .padding()
            }
                
            
            // Card Image
            RemoteImage(url: card.dzImageUrl)
                .frame(width: 300, height: 200)

                .aspectRatio(contentMode: .fit)

                .padding(30)

        Spacer()
        Spacer()
        Spacer()
        
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(height: 50)
                .padding(10)
                .overlay(
                    HStack {
                        Text("\"\(card.text)\"")
                            .font(.body)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.leading, 8)

                            .frame(maxWidth: 265)
                        Button(action: {
                            // Copy text to clipboard
                            copyTextToClipboard(text: card.themeTitle)
                        }) {
                            Text("Copy")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.pink)
                                    .opacity(0.3)
                                )
                                .foregroundColor(.pink)
                        }
                        .padding(.trailing, 8)
                    }
                )
                .padding(8)
        }
        
        Divider()

        HStack{
            Text("Share to")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        
            
            HStack {
                
             // Whatsapp
                Button(action: {
                    // Share using WhatsApp

                }) {
                    VStack{
                        Image("Whatsapp")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("WhatsApp")
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal, 10)
                        
                    }
                }
                
                // Instagram
                                  Button(action: {
                                      // Share using Instagram

                                  }) {
                                      VStack{
                                          Image("Instagram")
                                              .resizable()
                                              .frame(width: 40, height: 40)
                                          Text("Instagram")
                                              .foregroundColor(.black)
                                              .lineLimit(1)
                                              .minimumScaleFactor(0.5)
                                              .padding(.horizontal, 10)

                                      }
                                  }
                // Facebook
                Button(action: {
                                     
                                   }) {
                                       VStack{
                                           Image("Facebook")
                                               .resizable()
                                               .frame(width: 40, height: 40)
                                           Text("Facebook")
                                               .foregroundColor(.black)
                                               .lineLimit(1)
                                               .minimumScaleFactor(0.5)
                                               .padding(.horizontal, 10)

                                       }
                                   }
                
                // Download button
                Button(action: {
                    // Implement download action
                }) {
                    VStack{
                        Image(systemName: "square.and.arrow.down")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(30)
                        Text("Download")
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal, 10)

                    }
                }

                // More button (opens default iOS app selector)
                Button(action: {
                    isSelectorPresented = true
                }) {
                    VStack {
                        Image(systemName: "ellipsis")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(30)
                        Text("More")
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal, 10)
                    }
                }
                .sheet(isPresented: $isSelectorPresented) {
                    ShareActivityViewController(items: [card.themeTitle, card.dzImageUrl])
                }
                
                
                }
        .padding()
    }

    func copyTextToClipboard(text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }

}

