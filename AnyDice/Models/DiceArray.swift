//
//  DiceArray.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-31.
//

import Foundation

class DiceStack {
    
    var dices: [DiceSet]
    var isEmpty: Bool { return self.dices.count == 0 }
    
    init() {
        self.dices = []
    }
    
    func roll() -> Int {
        var result = 0
        for set in 0..<self.dices.count {
            for _ in 1...self.dices[set].quantity {
                result += Int.random(in: 1...self.dices[set].faces)
            }
        }
        return result
    }
    
}
