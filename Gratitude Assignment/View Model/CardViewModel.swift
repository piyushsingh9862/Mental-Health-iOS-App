//
//  CardViewModel.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 24/10/23.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var isLoading: Bool = true
    @Published var currentDate = Date()

    
    let placeholderImageURL = "Placeholder"
    
    
    func fetchData(forDate date: String) {
      

      isLoading = true

      guard
        let url = URL(
          string:
            "https://m67m0xe4oj.execute-api.us-east-1.amazonaws.com/prod/dailyzen/?date=\(date)&version=2"
        )
      else {
        isLoading = false  // Set isLoading to false on URL error
        return
      }

      URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
          print("API request error: \(error)")
          self.isLoading = false
          return
        }

        if let data = data {
          if let cardsData = try? JSONDecoder().decode([Card].self, from: data) {
            DispatchQueue.main.async {
              // Map CardData to Card model
              self.cards = cardsData.map { cardData in
                return Card(
                  dzImageUrl: cardData.dzImageUrl,
                  themeTitle: cardData.themeTitle,
                  dzType: cardData.dzType,
                  primaryCTAText: cardData.primaryCTAText,
                  text: cardData.text + " - " + cardData.author,
                  author: cardData.sharePrefix + " " + cardData.articleUrl,
                  articleUrl: cardData.articleUrl, sharePrefix: cardData.sharePrefix

                )
              }
              self.isLoading = false  // Set isLoading to false on successful data update
            }
            self.isLoading = false
          } else {
            print("Error decoding JSON")
            self.isLoading = false
          }
        }
      }.resume()
    }

    
    func loadPreviousDay() {
           
           guard let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else {
               return
           }
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyyMMdd" // Adjust the date format based on your API's requirements
           let previousDateString = dateFormatter.string(from: previousDate)
           currentDate = previousDate
           fetchData(forDate: previousDateString)
       }
    
    func loadNextDay() {
        
        guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let nextDayString = dateFormatter.string(from: nextDay)

        fetchData(forDate: nextDayString)
        currentDate = nextDay
    }
    
    var navigationBarTitle: String {
        let calendar = Calendar.current
        let today = Date()
        
        if calendar.isDate(currentDate, inSameDayAs: today) {
            return "TODAY"
        } else if calendar.isDate(currentDate, inSameDayAs: getPreviousDate(from: today)) {
            return "YESTERDAY"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd"
            return dateFormatter.string(from: currentDate)
        }
    }
    
    func getPreviousDate(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
    }

    func getNextDate(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
    }

    

    
   }

    


