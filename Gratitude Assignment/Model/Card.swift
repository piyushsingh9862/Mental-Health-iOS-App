//
//  Card.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 24/10/23.
//

import Foundation

struct Card: Identifiable, Decodable {
    let id = UUID()
    let dzImageUrl: String
    let themeTitle: String
    let dzType: String
    let primaryCTAText: String
    let text: String
    let author: String
    let articleUrl: String
    let sharePrefix: String
    
    enum CodingKeys: String, CodingKey {
        case dzImageUrl
        case themeTitle
        case dzType
        case primaryCTAText
        case text
        case author
        case articleUrl
        case sharePrefix
    }
}


