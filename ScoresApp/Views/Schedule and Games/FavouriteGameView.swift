//
//  FavouriteGameView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct FavouriteGameView: View {
    // View must be given game to be displayed and team's name
    var game:Game
    var teamName:String
    
    var body: some View {
        ZStack {
            
            // Card with different coloured shadow
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color:.blue, radius:  5)
            
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
                    if (game.Status != "Final") {
                        if let dateTime = game.DateTime {
                            Text("@ " + DateHelper.getTimeString(time: dateTime))
                        }
                        
                    }
                }
                
                // Additional elements to label favourite team
                HStack {
                    Image(systemName: "star.square.fill")
                        .foregroundColor(.yellow)
                    Text(teamName)
                        .bold()
                }
                .padding(.top)
            }
            .padding()
        }
    }
}

struct FavouriteGameView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteGameView(game: Constants.pastGame, teamName: "Atlanta Hawks")
    }
}
