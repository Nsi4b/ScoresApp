//
//  GameView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct GameView: View {
    var game:Game
    var body: some View {
        ZStack {
            
            // Card
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color:.gray, radius:  5)
            
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Spacer()
                    
                    
                    // Home team info + score
                    InfoColumnView(team: game.HomeTeam, score: game.HomeTeamScore)
                    
                    
                    Spacer()
                    Text("VS")
                    Spacer()
                    
                    // Away team info + score
                    InfoColumnView(team: game.AwayTeam, score: game.AwayTeamScore)
                    Spacer()
                }
               
                
                // Game status + scheduled time (if not final)
                HStack {
                    Text(game.Status)
                    if (game.Status == "Scheduled") {
                        if let dateTime = game.DateTime {
                            Text("@ " + DateHelper.getTimeString(time: dateTime))
                        } else {
                            Text("Cancelled")
                        }
                        
                    }
                }
            }
            .padding()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Constants.futureGame)
    }
}
