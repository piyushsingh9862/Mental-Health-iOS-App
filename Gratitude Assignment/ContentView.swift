//
//  ContentView.swift
//  Gratitude Assignment
//
//  Created by Piyush Singh on 24/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cardViewModel = CardViewModel()


  
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(cardViewModel.cards) { card in
                        CardView(card: card, cardViewModel: cardViewModel)
                            .padding(10)
                           
                    }
                    
                    Image("Image")
                        .padding()
                }
            }
            .onAppear {
                // Fetch data for the initial date when the view appears.
                cardViewModel.fetchData(forDate: "20230915")
            }
            .navigationBarItems(
                leading: Button("Previous") {

                    cardViewModel.loadPreviousDay()
            }
                    .foregroundColor(.pink)

                    .disabled(isPreviousButtonDisabled()),
            
        trailing:
                      HStack {
                          
                          Text(cardViewModel.navigationBarTitle)
                          .bold()
                          Spacer(minLength: 100)
                          
                          Button("Next") {

                              cardViewModel.loadNextDay()
                          }
                          .foregroundColor(isNextButtonEnabled ? .pink : .white)

                         .disabled(!isNextButtonEnabled)
                       

                      }
                  )

         
        }

    }
   
    
    
    
    func isPreviousButtonDisabled() -> Bool {
        // Calculate the date 7 days ago from the current date
        guard let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
            return true
        }
        
        // Check if the currentDate is earlier than seven days ago
        return cardViewModel.currentDate <= sevenDaysAgo
    }
    
    var isNextButtonEnabled: Bool {
        // Calculate the date for the next day
        guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: cardViewModel.currentDate) else {
            return false
        }

        // Check if the currentDate is earlier than or equal to today
        return nextDay <= Date()
    }
    
    
    


}


#Preview {
    ContentView()
}
