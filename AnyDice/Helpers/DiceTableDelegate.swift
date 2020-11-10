//
//  DiceTableDelegate.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import Foundation

protocol DiceTableDelegate: AnyObject {
    
    /// Called when we choose a row to change Dice type ( to choose a Dice with another number of faces)
    func didChooseCell(diceArrayIndex: Int)
    
    /// Called when we tap a stepper and change Dices quantity for particular array item
    func updateDicesQuantity(diceArrayIndex: Int, newDicesQuantity: Int)
    
}
