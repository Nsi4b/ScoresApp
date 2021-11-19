//
//  ContentView.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model:DataModel
    var body: some View {
        ZStack {
            TabView {
                
                ScheduleView(model: model)
                    .tabItem {
                        VStack {
                            Image(systemName: "sportscourt")
                            Text("Scores")
                        }
                    }
                StandingsView(model: model)
                    .tabItem {
                        VStack {
                            Image(systemName: "list.number")
                            Text("Standings")
                        }
                    }
                SettingsView(model: model)
                    .tabItem {
                        VStack {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: DataModel())
    }
}
