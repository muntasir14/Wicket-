//
//  Match.swift
//  Wicket
//
//  Created by IKRAMUZZAMAN MUNTASIR on 18/7/19.
//  Copyright © 2019 IKRAMUZZAMAN MUNTASIR. All rights reserved.
//

import Foundation

class Match {
    
    let team1Name: String
    let team2Name: String
    let firstBattingTeam: String
    var firstBattingTeamTotalRun: Int?
    var firstBattingTeamTotalWicketsFallen: Int?
    var firstBattingTeamOversTaken: String?
    
    var secondBattingTeamTotalRun: Int?
    var secondBattingTeamTotalWicketsFallen: Int?
    var secondBattingTeamOversTaken: String?
    let secondBattingTeam: String
    let numberOfPlayers: Int
    let numberOfOvers: Int
    
    init(team1Name: String, team2Name: String, firstBattingTeam: String, numberOfPlayers: Int, numberOfOvers: Int) {
        
        self.team1Name = team1Name
        self.team2Name = team2Name
        self.firstBattingTeam = firstBattingTeam
        if team1Name == firstBattingTeam {
            secondBattingTeam = team2Name
        }else {
            secondBattingTeam = team1Name
        }
        self.numberOfPlayers = numberOfPlayers
        self.numberOfOvers = numberOfOvers
    }
    
    func setFirstBattingTeamScore(run: Int, totalWicketsFallen: Int, oversTaken: String)  {
        
        self.firstBattingTeamTotalRun = run
        self.firstBattingTeamTotalWicketsFallen = totalWicketsFallen
        self.firstBattingTeamOversTaken = oversTaken
    }
    
    func setSecondBattingTeamScore(run: Int, totalWicketsFallen: Int, oversTaken: String)  {
        
        self.secondBattingTeamTotalRun = run
        self.secondBattingTeamTotalWicketsFallen = totalWicketsFallen
        self.secondBattingTeamOversTaken = oversTaken
    }
    
    func getWinner() -> String {
        
        if firstBattingTeamTotalRun! > secondBattingTeamTotalRun! {
            
            return firstBattingTeam
        }else if firstBattingTeamTotalRun! == secondBattingTeamTotalRun!{
            
            return "Tie!"
        }else {
            return secondBattingTeam
        }
    }
    
    func getTarget() -> Int {
        
        return firstBattingTeamTotalRun! + 1
    }
}
