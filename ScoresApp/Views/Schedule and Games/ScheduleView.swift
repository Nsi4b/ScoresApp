//
//  ScheduleView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct ScheduleView: View {
    
    // View observes the entire model
    @ObservedObject var model:DataModel
    
    var body: some View {
        ZStack {
            
            // Backdrop color
            Color("backdrop")
                .ignoresSafeArea()
            
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    
                    // MARK: - Header with title and logo
                    HStack{
                        Text("Games")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Image("nba")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    // Segmented style day picker
                    Picker(selection: $model.selectedDay, label: Text(""), content: {
                        Text("Yesterday").tag(DateCategory.yesterday)
                        Text("Today").tag(DateCategory.today)
                        Text("Tomorrow").tag(DateCategory.tomorrow)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                    // MARK: - Games
                    // Display games if the data for the selected day is not null (See DataModel.swift)
                    if let sched = model.scheduleDict[model.selectedDay] {
                        
                        
                        // Check if favourite team is playing AND if game is canceled
                        // Display if found
                        ForEach(sched!.games) { game in
                            if (game.HomeTeamID == model.favouriteTeam ||
                                    game.AwayTeamID == model.favouriteTeam) && game.Status != "Canceled" {
                                
                                // Display special view for favourite team's game
                                FavouriteGameView(game: game, teamName: Constants.teamNames[model.favouriteTeam])
                                Divider()
                            }
                        }
                        
                        
                        // All other games excluding the game with favourite team
                        // NOTE: This displays non-canceled games; games can be canceled
                        // in the playoffs if the series finished in less than 7 games
                        ForEach(sched!.games) { game in
                            if game.HomeTeamID != model.favouriteTeam &&
                                game.AwayTeamID != model.favouriteTeam &&
                                game.Status != "Canceled" {
                                GameView(game: game)
                            }
                        }
                        
                        
                        // Show the games count
                        let gamesCount = sched!.games.count
                        if gamesCount == 1 {
                            Text("\(gamesCount) Game")
                                .bold()
                        } else {
                            Text("\(gamesCount) Games")
                                .bold()
                                .padding(.bottom)
                        }
                        
                    } else {
                        Text("Null Schedule Instance")
                            .bold()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    
    // MARK: - Initializer for custom coloured picker
    init(model: DataModel) {
        self.model = model
        UISegmentedControl.appearance().selectedSegmentTintColor = .red
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(model: DataModel())
    }
}
