//
//  ConfigurationDelegate.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-31.
//

import Foundation

protocol ConfigurationDelegate: AnyObject {
    
    /// called when Dice configuration changed. Updates Dices in ManViewController
    func updateDices(diceSetArray: [DiceSet])
}
