//
//  StandingsView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct StandingsView: View {
    
    // View observes the model
    @ObservedObject var model:DataModel
    // Selected conference to be displayed (default is east)
    @State var selectedConf = "east"
    
    var body: some View {
        if let standings = model.standings {
            ZStack {
                // Backdrop color
                Color("backdrop")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        // MARK: - Header with title and logo
                        HStack{
                            Text("Standings")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                            Image("nba")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                        // Conference picker
                        Picker(selection: $selectedConf, label: Text(""), content: {
                            Text("East").tag("east")
                            Text("West").tag("west")
                        })
                        .pickerStyle(SegmentedPickerStyle())
                    }.padding(.horizontal)
                    Divider()
                    
                    
                    // MARK: - Standings legend
                    HStack{
                        Text("#")
                            .bold()
                            .frame(width: 25, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Team")
                            .bold()
                            .frame(width: 45, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                        
                        Text("W - L")
                            .bold()
                            .frame(width: 75, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - Calling the view for listing teams in order
                    if selectedConf == "east" {
                        ConferenceStandingsView(teams: standings.east, favouriteTeamID: model.favouriteTeam)
                    } else {
                        ConferenceStandingsView(teams: standings.west, favouriteTeamID: model.favouriteTeam)
                    }
                    
                }
            }
        }
        
    }
    
    
    // MARK: - Initializer for custom coloured picker
    init(model: DataModel) {
        self.model = model
        UISegmentedControl.appearance().selectedSegmentTintColor = .red
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black
        ], for: .normal)
    }
}


struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView(model: DataModel())
    }
}
