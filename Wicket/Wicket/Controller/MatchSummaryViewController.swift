//
//  MatchSummaryViewController.swift
//  Wicket
//
//  Created by IKRAMUZZAMAN MUNTASIR on 26/7/19.
//  Copyright © 2019 IKRAMUZZAMAN MUNTASIR. All rights reserved.
//

import UIKit

class MatchSummaryViewController: UIViewController {

    var thisMatch: Match?
    
    @IBOutlet weak var firstBattingTeamTextField: UILabel!
    @IBOutlet weak var fbtScoreTextField: UILabel!
    @IBOutlet weak var fbtOvers: UILabel!
    @IBOutlet weak var secondBattingTeamTextField: UILabel!
    @IBOutlet weak var targetTextField: UILabel!
    @IBOutlet weak var sbtScoreTextField: UILabel!
    @IBOutlet weak var sbtOversTextField: UILabel!
    
    
    @IBOutlet weak var resultTextField: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstBattingTeamTextField.text = thisMatch!.firstBattingTeam
        fbtScoreTextField.text = "\(thisMatch!.firstBattingTeamTotalRun!)/\(thisMatch!.firstBattingTeamTotalWicketsFallen!)"
        fbtOvers.text = thisMatch!.firstBattingTeamOversTaken!
        
        targetTextField.text = "Target: \(thisMatch!.getTarget())"
        secondBattingTeamTextField.text = thisMatch!.secondBattingTeam
        sbtScoreTextField.text = "\(thisMatch!.secondBattingTeamTotalRun!)/\(thisMatch!.secondBattingTeamTotalWicketsFallen!)"
        sbtOversTextField.text = thisMatch!.secondBattingTeamOversTaken!
        
        let result = thisMatch!.getWinner()
        if(result == "Tie!"){
            
            resultTextField.text = "Result: Match Tied!"
        }else {
            
            resultTextField.text = "Result: \(result) have won the match!"
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
