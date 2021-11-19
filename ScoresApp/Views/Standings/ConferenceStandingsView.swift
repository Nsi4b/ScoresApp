//
//  ConferenceStandingsView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct ConferenceStandingsView: View {
    
    // Array of teams to be displayed + favourite team id
    var teams:[Team]
    var favouriteTeamID:Int
    
    var body: some View {
        LazyVStack {
            
            // Foreach with enumerated array for placement #
            ForEach(Array(teams.enumerated()), id: \.offset) { offset, t in
                ZStack{
                    
                    // Card
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .shadow(color: .gray, radius: 5)
                    
                    // MARK: - Individual team info
                    HStack {
                        
                        // Seed number
                        Text(String(offset + 1))
                            .bold()
                            .frame(width: 30, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        // Team logo
                        Image(t.Key)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.vertical)
                        
                        // Team city and name
                        Text("\(t.City) \(t.Name)")
                            .bold()
                        
                        // Star if team is favourited
                        if t.TeamID == favouriteTeamID {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        
                        Spacer()
            
                        // Win-Loss record
                        Text("\(t.Wins) - \(t.Losses)")
                            .frame(width: 60, height: 20, alignment: .center)
                            .padding(.trailing)
                    }
                }
            }
        }.padding(.horizontal)
    }
}

struct ConferenceStandingsView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceStandingsView(teams: DataModel().standings!.east, favouriteTeamID: 10)
    }
}
