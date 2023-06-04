//
//  xOrOButton.swift
//  TicTacToe
//
//  Created by Anderson Chin on 31/5/2023.
//

import UIKit

class xOrOButton: UIButton {
    
    var tapped : Bool = false
    var vc : TicTacToeVC?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(vc:TicTacToeVC) {
        super.init(frame: .zero)
        self.vc = vc
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(){
        setToBoard()
        if checkVictory() {
            var winner: String
            if self.currentTitle == "O" {
                winner = "Noughts"
            }
            else {
                winner = "Crosses"
            }
            
            let alert = UIAlertController(title: winner + " Wins", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (alert: UIAlertAction!) in self.vc!.reset()}))
            vc!.present(alert,animated:true)
            return
        }
        else if fullBoard() {
            let alert = UIAlertController(title: "DRAW" , message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (alert: UIAlertAction!) in self.vc!.reset()}))
            vc!.present(alert,animated:true)
        }
    }
    
    func reset() {
        tapped = false
        setTitle("", for: .normal)
        GlobalVars.whoseTurn.text = "O's"
        self.isEnabled = true

    }
    
    func setToBoard() {
        if GlobalVars.turn % 2 == 0 {
            setTitle("O",for:.normal)
            tapped = true
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
    
    func fullBoard() -> Bool{
        for i in GlobalVars.buttons {
            if !i.tapped {
                return false
            }
        }
        return true
    }
}
