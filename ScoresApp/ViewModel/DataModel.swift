//
//  DataModel.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import Foundation

class DataModel: ObservableObject {
    // Dictionary of schedule instances
    @Published var scheduleDict:[DateCategory:Schedule?] = [:]
    
    // Current selected date
    // Uses an enum for the three dates - see DateHelper.swift
    @Published var selectedDay:DateCategory
    
    // Standings instance
    @Published var standings:Standings?
    
    // Favourite team
    @Published var favouriteTeam:Int
    
    
    init() {
        // Default day is today; favourite team is none
        self.selectedDay = DateCategory.today
        self.favouriteTeam = 0
        
        // Load data from API
        // NOTE: Use these four calls (comment out bottom 4) for real API calls
        loadSched(day: DateCategory.yesterday)
        loadSched(day: DateCategory.today)
        loadSched(day: DateCategory.tomorrow)
        loadStandings()
        
        
        // USE ENUMS HERE! OFFLINE DATA IS BROKEN
        
        
        // Load offline data
        // NOTE: Use these four calls (comment out previous 4) to use data from JSON as friendlier sample data
//        self.scheduleDict[DateCategory.yesterday] = OfflineService.getSched(filename: "pastgames")
//        self.scheduleDict[DateCategory.today] = OfflineService.getSched(filename: "nogames")
//        self.scheduleDict[DateCategory.tomorrow] = OfflineService.getSched(filename: "futuregames")
//        self.standings = OfflineService.getStandings(filename: "standings")
        
    }
    
    
    // Load a schedule from API
    // Takes the day as a string, which is used as the key for the schedule in scheduleDict
    func loadSched(day: DateCategory) {
        
        
        // Retrieve properly formatted date for API call
        let formattedDate = DateHelper.getDateString(day: day)
        
        
        // Create URL
        guard let url = URL(string:"https://fly.sportsdata.io/v3/nba/scores/json/GamesByDate/\(formattedDate)?key=\(Constants.apiKey)") else {
            fatalError("BAD URL FOR SCHEDULE")
        }
        
        // Data task for API Call
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if error == nil && data != nil {
                    
                    // Parse incoming JSON; will be parsed as an array of games
                    let decoder = JSONDecoder()
                    let incomingData = try decoder.decode([Game].self, from: data!)
                    
                    // Assign each game an id
                    for g in incomingData {
                        g.id = UUID()
                    }
                    
                    // Create a new schedule object, give it the newly parsed array of games and add to dictionary
                    let newSched = Schedule()
                    DispatchQueue.main.async {
                        newSched.games = incomingData
                        self.scheduleDict[day] = newSched
                    }
                }
            } catch {
                fatalError("Failed to parse JSON into Schedule! \n\(error)")
            }
        }.resume()
    }
    
    
    // Load standings from API
    func loadStandings() {
        
        // Create URL
        guard let url = URL(string: "https://fly.sportsdata.io/v3/nba/scores/json/Standings/2021?key=\(Constants.apiKey)") else {
            fatalError("BAD URL FOR STANDINGS")
        }
        
        // Data task for API call
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if error == nil && data != nil {
                    
                    // Parse incoming JSON; will be parsed as an array of teams
                    let decoder = JSONDecoder()
                    var incomingData = try decoder.decode([Team].self, from: data!)
                    
                    // Assign each team an id
                    for t in (0..<incomingData.count) {
                        incomingData[t].id = UUID()
                    }
                    
                    // Create a new team object, give it the array of teams, sort it, assign it to model's standings property
                    // See Standings.swift
                    var newStandings = Standings()
                    DispatchQueue.main.async {
                        newStandings.teams = incomingData
                        newStandings.sortConferences()
                        self.standings = newStandings
                    }
                }
            } catch {
                fatalError("Failed to parse JSON into Standings! \n\(error)")
            }
        }.resume()
    }
}
