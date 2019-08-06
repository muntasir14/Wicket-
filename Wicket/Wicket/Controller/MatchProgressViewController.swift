//
//  MatchProgressViewController.swift
//  Wicket
//
//  Created by IKRAMUZZAMAN MUNTASIR on 25/7/19.
//  Copyright © 2019 IKRAMUZZAMAN MUNTASIR. All rights reserved.
//

import UIKit

class MatchProgressViewController: UIViewController {

    var thisMatch: Match?
    var innings: Innings?
    let allOutcomes = ["Dot!", "1", "2", "3", "4", "5", "6", "Wicket!", "Wide", "No Ball", "No + 1", "No + 2", "No + 3", "No + 4", "No + 6", "Wd + 4", "Wd + 1", "Wd + 2", "Wd + 3"]
    
    @IBOutlet weak var matchTitleLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var oversLabel: UILabel!
    @IBOutlet weak var crrLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var rrrLabel: UILabel!
    @IBOutlet weak var thisBallTextField: UILabel!
    @IBOutlet weak var thisBallOutcomesPickerView: UIPickerView!
    
    var battingTeam: String?
    var isFirstInnings: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //currentScoreLabel.text = thisMatch?.firstBattingTeam
        let totalWickets = (thisMatch!.numberOfPlayers - 1)
        let totalBalls = thisMatch!.numberOfOvers * 6
        innings = Innings(isFirstinnings: isFirstInnings!, totalWickets: totalWickets, totalBalls: totalBalls)
        
        if isFirstInnings! {
            targetLabel.isHidden = true         // first innings
            rrrLabel.isHidden = true
            battingTeam = thisMatch!.firstBattingTeam
        }else {
            targetLabel.text = "Target: \(thisMatch!.getTarget())"
            innings!.targetedRun = thisMatch!.getTarget()
        }
        initUI(team1Name: thisMatch!.team1Name, team2Name: thisMatch!.team2Name)
    }
    
    func initUI(team1Name: String, team2Name: String) {
        
        matchTitleLabel.text = "\(team1Name) VS \(team2Name)"
        let battingTeamInitials = String(Array(battingTeam!)[0...2])
        currentScoreLabel.text = "\(battingTeamInitials): 0/0"
        oversLabel.text = "Overs: 0.0 (\(thisMatch!.numberOfOvers))"
        crrLabel.text = "CRR: 0.00"
        let rrr = innings!.getRRR()
        rrrLabel.text = "RRR: \(rrr)"
        
        thisBallOutcomesPickerView.delegate = self
    }
    
    func updateModel() {
        
        let thisBallOutcome = thisBallTextField.text!
        
        switch thisBallOutcome {
        case "Dot!":
            innings!.increaseBall()
        case "1", "2", "3", "4", "5", "6":
            innings!.increaseRun(runsToAdd: Int(thisBallOutcome)!)
            innings!.increaseBall()
        case "Wicket!":
            innings!.fallOfAWicket()
            innings!.increaseBall()
        case "Wide", "Wd + 1", "Wd + 2", "Wd + 3", "Wd + 4":
            if thisBallOutcome != "Wide"{
                let runsToBeAdded = Int(String(Array(thisBallOutcome)[5]))! + 1
                innings!.increaseRun(runsToAdd: runsToBeAdded)
            }else {
                innings!.increaseRun(runsToAdd: 1)
            }
        case "No Ball", "No + 1", "No + 2", "No + 3", "No + 4", "No + 6":
            if thisBallOutcome != "No Ball"{
                let runsToBeAdded = Int(String(Array(thisBallOutcome)[5]))! + 1
                innings!.increaseRun(runsToAdd: runsToBeAdded)
            }else {
                innings!.increaseRun(runsToAdd: 1)
            }
            default:
            print("Error")
        }
        
    }
    
    func updateView() {
        
        let ballsDelivered = innings!.ballsDelivered
        let currentRun = innings!.currentRun
        let wicketsFallen = innings!.wicketsFallen
        let crr = innings!.getCRR()
        
        let battingTeamInitials = String(Array(battingTeam!)[0...2])
        currentScoreLabel.text = "\(battingTeamInitials): \(currentRun)/\(wicketsFallen)"
        
        let overs = "Overs: \(ballsDelivered / 6).\(ballsDelivered % 6) (\(thisMatch!.numberOfOvers))"
        oversLabel.text = overs
        
        crrLabel.text = "CRR: \(String(format: "%.2f", crr))"
        
        if !isFirstInnings! {
            let rrr = innings!.getRRR()
            rrrLabel.text = "RRR: \(String(format: "%.2f", rrr))"
        }
    }
    
    @IBAction func nextBallButtonPressed(_ sender: UIButton) {
    
        updateModel()
        updateView()
        print("\(innings!.currentRun)/\(innings!.wicketsFallen) in \(innings!.ballsDelivered) balls")
        if innings!.isInningsFinnished() {
            
            print("Innings finished")
            
            if isFirstInnings! {
                
                let oversTaken = oversLabel.text!
                thisMatch!.setFirstBattingTeamScore(run: innings!.currentRun, totalWicketsFallen: innings!.wicketsFallen, oversTaken: oversTaken)
                performSegue(withIdentifier: "goToIntermediatePage", sender: self)
            }else {
                
                let oversTaken = oversLabel.text!
                thisMatch!.setSecondBattingTeamScore(run: innings!.currentRun, totalWicketsFallen: innings!.wicketsFallen, oversTaken: oversTaken)
                print("run: \(innings!.currentRun)")
                print("\(thisMatch!.getWinner()) have won the Match!")
                performSegue(withIdentifier: "goToMatchSummary", sender: self)
                // matchFinished
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToIntermediatePage") {
            
            let intPageVC = segue.destination as! IntermediatePageViewController
            intPageVC.thisMatch = thisMatch
            
        }
        if(segue.identifier == "goToMatchSummary") {
            
            let summaryPageVC = segue.destination as! MatchSummaryViewController
            summaryPageVC.thisMatch = thisMatch
        }
    }
    
}



extension MatchProgressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allOutcomes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allOutcomes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        thisBallTextField.text = allOutcomes[row]
    }
    
}
