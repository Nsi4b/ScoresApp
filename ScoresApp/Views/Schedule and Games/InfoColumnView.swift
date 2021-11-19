//
//  InfoColumnView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct InfoColumnView: View {
    var team: String
    var score: Int?
    var body: some View {
        VStack(alignment: .center) {
            // Logo
            Image(team)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            // Team label
            Text(team)
            // Score
            if let score = score {
                Text(String(score))
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .multilineTextAlignment(.center)
            } else {
                Text("-")
            }
        }
        .padding()
    }
}

struct InfoColumnView_Previews: PreviewProvider {
    static var previews: some View {
        InfoColumnView(team: Constants.pastGame.HomeTeam, score: Constants.pastGame.HomeTeamScore)
    }
}
