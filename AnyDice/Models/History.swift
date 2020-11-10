//
//  History.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-11-02.
//

import Foundation

class History {
    
    var rollsHistory: [[String: String]] = []
    
    func addRecord(dices: [DiceSet], result: Int) {
        
        let diceConfig = self.dicesConfigToString(dices: dices)
        
        // History can contain max 100 record
        if self.rollsHistory.count == 100 {
            self.rollsHistory.remove(at: 99)
        }
        self.rollsHistory.insert(["diceConfig" : diceConfig, "result": String(result)], at: 0)
    }
    
    /// saves History to UserDefaults
    func saveToUserDefaults() {
        if let data = try? PropertyListEncoder().encode(self.rollsHistory) {
            UserDefaults.standard.set(data, forKey: "RollsHistory")
        } else {
            Logger.error("Error while encoding self.dices.")
        }
    }
    
    /// reads History from UserDefaults
    func restoreFromUserDefaults() {
        guard let data = UserDefaults.standard.object(forKey: "RollsHistory") as? Data else {
            debugPrint("Error in History.restoreFromUserDefaults() while reading data from UserDefaults.")
            return
        }
        if let rollsHistoryArray = try? PropertyListDecoder().decode([[String: String]].self, from: data) {
            self.rollsHistory = rollsHistoryArray
        } else {
            Logger.error("Error while decoding data from UserDefaults.")
        }
    }
    
    /// takes array of DiceSet, returns Dices configuration as a string (f.e. "3d6 2d4 1d12")
    private func dicesConfigToString(dices: [DiceSet]) -> String {
        var str = ""
        dices.forEach { diceSet in
            str.append("\(diceSet.quantity)d\(diceSet.faces) ")
        }
        return str
    }
    
}
