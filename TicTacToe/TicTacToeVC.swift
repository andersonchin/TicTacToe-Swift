//
//  TicTacToeVC.swift
//  TicTacToe
//
//  Created by Anderson Chin on 30/5/2023.
//

import UIKit

class TicTacToeVC: UIViewController {
    
    let verticalStack : UIStackView = UIStackView()
    let resetButton :UIButton = UIButton()
    let turnLabel = GlobalVars.turnLabel
    let turn = GlobalVars.whoseTurn
    var whoStarts = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureVertical()
        configureLabel()
        configureReset()
        addToStackView()
    }
    
    func configureVertical() {
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 5
        verticalStack.axis = .vertical
        verticalStack.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            verticalStack.widthAnchor.constraint(equalToConstant: 325),
            verticalStack.heightAnchor.constraint(equalToConstant: 325),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func configureLabel() {
        view.addSubview(turnLabel)
        view.addSubview(turn)
        turnLabel.translatesAutoresizingMaskIntoConstraints = false
        turnLabel.text = "Turn"
        turn.translatesAutoresizingMaskIntoConstraints = false
        turn.text = "O's"
        turnLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        turn.font = UIFont.systemFont(ofSize: 40, weight: .heavy)

        NSLayoutConstraint.activate([
            turnLabel.topAnchor.constraint(equalTo: turn.bottomAnchor, constant: 10),
            turnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            turn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            turn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    
    func configureHorizontal(horizontalStack: UIStackView) {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 5
        horizontalStack.axis = .horizontal
    }
    
    func addToStackView() {
        for _ in 1...3 {
            let horizontalStack = UIStackView()
            configureHorizontal(horizontalStack: horizontalStack)
            for _ in 1...3 {
                let button = xOrOButton(vc: self)
                horizontalStack.addArrangedSubview(button)
                GlobalVars.buttons.append(button)
            }
            verticalStack.addArrangedSubview(horizontalStack)
        }
    }
    
    func configureReset() {
        view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setImage(UIImage(named: "replay"), for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalToConstant: 50),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 50)
        ])
    }
    
    @objc func reset() {
        whoStarts += 1
        GlobalVars.turn = whoStarts
        for i in GlobalVars.buttons {
            i.reset()
        }
//        GlobalVars.turn = GlobalVars.turn % 2
    }
    
}
