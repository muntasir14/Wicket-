//
//  IntermediatePageViewController.swift
//  Wicket
//
//  Created by IKRAMUZZAMAN MUNTASIR on 26/7/19.
//  Copyright © 2019 IKRAMUZZAMAN MUNTASIR. All rights reserved.
//

import UIKit

class IntermediatePageViewController: UIViewController {

    var thisMatch: Match?
    
    @IBOutlet weak var teamNameTextField: UILabel!
    @IBOutlet weak var scoreTextField: UILabel!
    @IBOutlet weak var oversTextField: UILabel!
    
    @IBOutlet weak var team2TargetTextField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamNameTextField.text = thisMatch!.firstBattingTeam
        scoreTextField.text = "\(thisMatch!.firstBattingTeamTotalRun!)/\(thisMatch!.firstBattingTeamTotalWicketsFallen!)"
        oversTextField.text = thisMatch!.firstBattingTeamOversTaken
        team2TargetTextField.text = "\(thisMatch!.secondBattingTeam) needs \(thisMatch!.getTarget()) to win"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startSecondInningsButtonPressed(_ sender: Any) {
    
        performSegue(withIdentifier: "goBackToProgressPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goBackToProgressPage") {
            
            let matchProgressPageVC = segue.destination as! MatchProgressViewController
            matchProgressPageVC.thisMatch = thisMatch
            matchProgressPageVC.isFirstInnings = false
            matchProgressPageVC.battingTeam = thisMatch!.secondBattingTeam
        }
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
