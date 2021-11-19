//
//  SettingsView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct SettingsView: View {
    // View observes and writes to entire model
    @ObservedObject var model:DataModel
    
    var body: some View {
        ZStack {
            
            // Backdrop color
            Color("backdrop")
                .ignoresSafeArea()
            
            // MARK: - Header with title and logo
            VStack{
                HStack{
                    Text("Settings")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Image("nba")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                Spacer()
                
                
                // MARK: - Favourite team picker
                VStack(alignment: .center) {
                    Text("Favourite Team:")
                    Picker(selection: $model.favouriteTeam, label: Text(""), content: {
                        ForEach(0..<Constants.teams.count) { i in
                            Text(Constants.teamNames[i]).tag(i)
                        }
                    })
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(model: DataModel())
    }
}
