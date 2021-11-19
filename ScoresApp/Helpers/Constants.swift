//
//  Constants.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import Foundation

class Constants {
    // Sample games for views
    static let pastGame = Game(status: "Final", time: "2021-05-16T19:00:00", away: "HOU", home: "ATL", awayID: 22, homeID: 3, awayScore: 89, homeScore: 117)
    static let futureGame = Game(status: "Scheduled", time: "2021-05-18T18:30:00", away: "CHA", home: "IND", awayID: 2, homeID: 13, awayScore: nil, homeScore: nil)
    
    // Team keys
    static let teams = ["NONE", "WAS", "CHA", "ATL", "MIA", "ORL", "NY", "PHI", "BKN", "BOS", "TOR", "CHI", "CLE", "IND", "DET", "MIL", "MIN", "UTA", "OKC", "POR", "DEN", "MEM", "HOU", "NO", "SA", "DAL", "GS", "LAL", "LAC", "PHO", "SAC"]
    
    // Team labels
    static let teamNames = ["None", "Washington Wizards", "Charlotte Hornets", "Atlanta Hawks", "Miami Heat", "Orlando Magic", "New York Knicks", "Philadelphia 76ers", "Brooklyn Nets", "Boston Celtics", "Toronto Raptors", "Chicago Bulls", "Cleveland Cavaliers", "Indiana Pacers", "Detroit Pistons", "Milwaukee Bucks", "Minnesota Timberwolves", "Utah Jazz", "OKC Thunder", "Portland Trail Blazers", "Denver Nuggets", "Memphis Grizzlies", "Houston Rockets", "New Orleans Pelicans", "San Antonio Spurs", "Dallas Mavericks", "Golden State Warriors", "LeBron James", "LA CLippers", "Phoenix Suns", "Sacramento Kings"]
    
    // API Key
    static let apiKey = "6847ce2fa206408fb0b4b1df6616f393"
}
