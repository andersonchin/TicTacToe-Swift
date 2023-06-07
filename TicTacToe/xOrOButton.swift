//
//  xOrOButton.swift
//  TicTacToe
//
//  Created by Anderson Chin on 31/5/2023.
//

import UIKit

//delegate protocol
protocol xOrOButtonDelegate {
    func presentResult(alert: UIAlertController)
    func callReset()
}

class xOrOButton: UIButton {
    
    var tapped : Bool = false
    var delegate: xOrOButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //configure button
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    //functionality when button is tapped
    @objc func buttonTapped(){
        //add X or O to board
        setToBoard()
        
        //check if victory has been reached
        if checkVictory() {
            //determine winner
            var winner: String
            if self.currentTitle == "O" {
                winner = "Noughts"
            }
            else {
                winner = "Crosses"
            }
            
            //call delegate functions to present result and reset board
            let alert = UIAlertController(title: winner + " Wins", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (alert: UIAlertAction!) in self.delegate?.callReset()}))
            delegate?.presentResult(alert: alert)
            return
        }
        //otherwise, check if draw condition is reached
        else if fullBoard() {
            //call delegate functions to present result and reset board
            let alert = UIAlertController(title: "DRAW" , message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (alert: UIAlertAction!) in self.delegate?.callReset()}))
            delegate?.presentResult(alert: alert)
        }
    }
    
    //reset the current buttons properties
    func reset() {
        tapped = false
        setTitle("", for: .normal)
        self.isEnabled = true

    }
    
    //update button to show X or O depending on whose turn it is
    func setToBoard() {
        if GlobalVars.turn % 2 == 0 {
            setTitle("O",for:.normal)
            //set the current button as tapped (used to check for draw case)
            tapped = true
            //change turn
            GlobalVars.turn = 1
            GlobalVars.whoseTurn.text = "X's"
        } else {
            setTitle("X",for:.normal)
            tapped = true
            GlobalVars.turn = 0
            GlobalVars.whoseTurn.text = "O's"
        }
        self.isEnabled = false
    }
    

    func checkVictory() -> Bool {
        //Check for horizontal victory
        if GlobalVars.buttons[0].currentTitle == self.currentTitle && GlobalVars.buttons[1].currentTitle == self.currentTitle && GlobalVars.buttons[2].currentTitle == self.currentTitle {
            return true
        }
        
        if GlobalVars.buttons[3].currentTitle == self.currentTitle && GlobalVars.buttons[4].currentTitle == self.currentTitle && GlobalVars.buttons[5].currentTitle == self.currentTitle {
            return true
        }
        
        if GlobalVars.buttons[6].currentTitle == self.currentTitle && GlobalVars.buttons[7].currentTitle == self.currentTitle && GlobalVars.buttons[8].currentTitle == self.currentTitle {
            return true
        }
        
        //check for vertical victory
        
        if GlobalVars.buttons[0].currentTitle == self.currentTitle && GlobalVars.buttons[3].currentTitle == self.currentTitle && GlobalVars.buttons[6].currentTitle == self.currentTitle {
            return true
        }
        
        if GlobalVars.buttons[1].currentTitle == self.currentTitle && GlobalVars.buttons[4].currentTitle == self.currentTitle && GlobalVars.buttons[7].currentTitle == self.currentTitle {
            return true
        }
        
        if GlobalVars.buttons[2].currentTitle == self.currentTitle && GlobalVars.buttons[5].currentTitle == self.currentTitle && GlobalVars.buttons[8].currentTitle == self.currentTitle {
            return true
        }
        
        //check for diagonal victory
        
        if GlobalVars.buttons[0].currentTitle == self.currentTitle && GlobalVars.buttons[4].currentTitle == self.currentTitle && GlobalVars.buttons[8].currentTitle == self.currentTitle {
            return true
        }
        
        if GlobalVars.buttons[2].currentTitle == self.currentTitle && GlobalVars.buttons[4].currentTitle == self.currentTitle && GlobalVars.buttons[6].currentTitle == self.currentTitle {
            return true
        }
        
        return false
    }
    
    //check for draw case
    func fullBoard() -> Bool{
        for i in GlobalVars.buttons {
            //if any buttons are not yet tapped return false, else full board, return true
            if !i.tapped {
                return false
            }
        }
        return true
    }
}
