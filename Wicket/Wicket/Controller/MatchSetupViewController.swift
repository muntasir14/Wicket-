//
//  MatchSetupViewController.swift
//  Wicket
//
//  Created by IKRAMUZZAMAN MUNTASIR on 18/7/19.
//  Copyright © 2019 IKRAMUZZAMAN MUNTASIR. All rights reserved.
//

import UIKit

class MatchSetupViewController: UIViewController {

    
    @IBOutlet weak var team1TextField: UITextField!
    @IBOutlet weak var team2TextField: UITextField!
    @IBOutlet weak var playersPerTeamTextField: UITextField!
    
    @IBOutlet weak var totalOversTextField: UITextField!
    @IBOutlet weak var tossTextField: UITextField!
    @IBOutlet weak var tossDecisionTextField: UITextField!
    
    @IBOutlet weak var fillAllBoxesLabel: UILabel!
    
    var thisMatch: Match?
    var currentTextField = UITextField()
    var tossPicker: UIPickerView?
    
    var selectedRow = 0
    let tossOptions = ["Bat", "Field"]
    var selectedTossOption: String?
    var tossWinningTeam: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTossDecisionPicker()
        // Do any additional setup after loading the view.
    }
    
    // Creating tossDecisionPicker
    func createTossDecisionPicker() {
        
        tossPicker = UIPickerView()
        tossPicker!.delegate = self
        tossPicker!.sizeToFit()
        
        tossDecisionTextField.inputView = tossPicker
        tossTextField.inputView = tossPicker
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startMatchButton(_ sender: Any) {
        
        let firstBattingTeam: String
        if (team1TextField.text == "") || (team2TextField.text == "") || (playersPerTeamTextField.text == "") || (totalOversTextField.text == "") || (tossTextField.text == "") || (tossDecisionTextField.text == "") {
            fillAllBoxesLabel.text = "Fill all boxes"
        }else {
            
            if (tossWinningTeam == team1TextField.text) && (tossDecisionTextField.text == "Bat") {
                firstBattingTeam = team1TextField.text!
            }else if(tossWinningTeam == team2TextField.text) && (tossDecisionTextField.text == "Bat"){
                firstBattingTeam = team2TextField.text!
            }else if (tossWinningTeam == team1TextField.text) && (tossDecisionTextField.text == "Field") {
                firstBattingTeam = team2TextField.text!
            }else {
                firstBattingTeam = team1TextField.text!
            }
            
            print("Bats first: \(firstBattingTeam)")
            let playersPerTeam = Int(playersPerTeamTextField.text!)!
            let totalOvers = Int(totalOversTextField.text!)!
            
            thisMatch = Match(team1Name: team1TextField.text!, team2Name: team2TextField.text!, firstBattingTeam: firstBattingTeam, numberOfPlayers: playersPerTeam, numberOfOvers: totalOvers)
            
            performSegue(withIdentifier: "startMatchSegue", sender: self)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "startMatchSegue") {
            
            let matchProgressVC = segue.destination as! MatchProgressViewController
            matchProgressVC.thisMatch = thisMatch
            matchProgressVC.isFirstInnings = true
        }
    }
}

extension MatchSetupViewController: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //team1TextField.resignFirstResponder()
        
        
        return true
    }
}

extension MatchSetupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tossOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentTextField == tossDecisionTextField {
            
            return tossOptions[row]
        }else {
            
            if row == 0 {
                
                return team1TextField.text
            }else {
                
                return team2TextField.text
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currentTextField == tossDecisionTextField {
            
            selectedTossOption = tossOptions[row]
            tossDecisionTextField.text = selectedTossOption
        }else {
            
            if row == 0 {
                
                tossWinningTeam = team1TextField.text
                
            }else {
                
                tossWinningTeam = team2TextField.text
            }
            tossTextField.text = tossWinningTeam
        }
        
        selectedRow = row
        
    }
    
}

extension MatchSetupViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        tossPicker!.reloadAllComponents()
        
        currentTextField = textField
        
        if currentTextField == tossDecisionTextField {
            
            selectedTossOption = tossOptions[selectedRow]
            tossDecisionTextField.text = selectedTossOption
        }else {
            
            if selectedRow == 0 {
                
                tossWinningTeam = team1TextField.text
                
            }else {
                
                tossWinningTeam = team2TextField.text
            }
            tossTextField.text = tossWinningTeam
        }
    }
}
