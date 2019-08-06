//
//  Inings.swift
//  Wicket
//
//  Created by IKRAMUZZAMAN MUNTASIR on 18/7/19.
//  Copyright © 2019 IKRAMUZZAMAN MUNTASIR. All rights reserved.
//

import Foundation

class Innings {
    
    var isFirstInnings: Bool
    var currentRun: Int
    var wicketsFallen: Int
    let totalWickets: Int
    let totalBalls: Int
    var ballsDelivered: Int
    var targetedRun: Int
    
    init(isFirstinnings: Bool, totalWickets: Int, totalBalls: Int) {
        
        self.isFirstInnings = isFirstinnings
        self.totalWickets = totalWickets
        self.totalBalls = totalBalls
        currentRun = 0
        wicketsFallen = 0
        ballsDelivered = 0
        targetedRun = 0
    }
    
    func isInningsFinnished() -> Bool {
        
        if (ballsDelivered == totalBalls) || (wicketsFallen == totalWickets) {
            
            return true
        }
        if !isFirstInnings && (currentRun >= targetedRun) {
            
            return true
        }
        return false
    }
    /*
    func startNewInnings()  {
        
        currentRun = 0
        wicketsFallen = 0
        ballsDelivered = 0
        isFirstInnings = false
    }
 */
    
    func increaseRun(runsToAdd: Int) {
        
        currentRun += runsToAdd
    }
    
    func increaseBall(){
        ballsDelivered += 1
    }
    
    func fallOfAWicket()  {
        
        wicketsFallen += 1
    }
    
    func getCRR() -> Double {
        
        return ((Double(currentRun) / Double(ballsDelivered)) * 6.0)
        
    }
    
    func getRRR() -> Double {
        
        let ballsRem = getBallsRem()
        let runsReq = getRunsReq()
        
        var rrr = (Double(runsReq) / Double(ballsRem)) * 6.0
        if rrr < 0.00 {
            rrr = 0.00
        }
        
        return rrr
    }
    
    func getRunsReq() -> Int {
        
        return (targetedRun - currentRun)
    }
    
    func getBallsRem() -> Int {
        
        return (totalBalls - ballsDelivered)
    }
}
