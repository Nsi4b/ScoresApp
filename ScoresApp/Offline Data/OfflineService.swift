//
//  OfflineService.swift
//  ScoresApp
//
//  Created by Philip on 26.10.2021.
//

import Foundation

// This class is meant to parse data from the JSON files as sample data
// JSON files reflect data from actual API calls
class OfflineService {
    
    // Get schedule from JSON, returns a Schedule instance
    static func getSched(filename:String) -> Schedule {
        let pathString = Bundle.main.path(forResource: filename, ofType: "json")
        
        guard pathString != nil else {
            return Schedule()
        }
        
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            do {
                let schedule = Schedule()
                let schedData = try decoder.decode([Game].self, from: data)
                for g in schedData{
                    g.id = UUID()
                }
                schedule.games = schedData
                return schedule
            } catch {
                // error in parsing JSON
                print(error)
            }
        } catch {
            // error in getting data
            print(error)
        }
        return Schedule()
    }
    
    
    // Get standings from JSON, returns a Standings instance
    static func getStandings(filename:String) -> Standings {
        let pathString = Bundle.main.path(forResource: filename, ofType: "json")
        
        guard pathString != nil else {
            return Standings()
        }
        
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            do {
                var standings = Standings()
                var standingData = try decoder.decode([Team].self, from: data)
                for t in (0..<standingData.count) {
                    standingData[t].id = UUID()
                }
                standings.teams = standingData
                standings.sortConferences()
                return standings
            } catch {
                // error in parsing JSON
                print(error)
            }
        } catch {
            // error in getting data
            print(error)
        }
        return Standings()
    }
}
