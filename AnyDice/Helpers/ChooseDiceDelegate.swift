//
//  ChooseDiceDelegate.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-30.
//

import Foundation

protocol ChooseDiceDelegate: AnyObject {
    
    /// Called when we choose a new type of Dice instead of the old one
    /// Updates Dice type at DiceArray.[diceArrayIndex]
    func updateDiceFaces(diceArrayIndex: Int, diceFaces: Int)
    
}
