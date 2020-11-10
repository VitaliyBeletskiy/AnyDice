//
//  DiceStack.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-31.
//

import Foundation

class DiceStack {
    
    var dices: [DiceSet]
    var isEmpty: Bool { return self.dices.count == 0 }
    var minValue: Int {
        var min = 0
        for diceSet in self.dices {
            min += diceSet.quantity
        }
        return min
    }
    var maxValue: Int {
        var max = 0
        for diceSet in self.dices {
            max += diceSet.quantity * diceSet.faces
        }
        return max
    }
    
    init() {
        self.dices = []
    }
    
    func roll() -> Int {
        var result = 0
        for diceSet in self.dices {
            for _ in 1...diceSet.quantity {
                result += Int.random(in: 1...diceSet.faces)
            }
        }
        return result
    }
    
    /// saves Dices configuration to UserDefaults
    func saveToUserDefaults() {
        if let data = try? PropertyListEncoder().encode(self.dices) {
            UserDefaults.standard.set(data, forKey: "Dices")
        } else {
            Logger.error("Error while encoding self.dices.")
        }
    }
    
    /// reads Dices configuration from UserDefaults
    func restoreFromUserDefaults() {
        guard let data = UserDefaults.standard.object(forKey: "Dices") as? Data else {
            Logger.error("Error while reading data from UserDefaults.")
            return
        }
        if let diceSetArray = try? PropertyListDecoder().decode([DiceSet].self, from: data) {
            self.dices = diceSetArray
        } else {
            Logger.error("Error while decoding data from UserDefaults.")
        }
    }
    
}
