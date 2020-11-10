//
//  DiceSet.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import Foundation

/// represents a set of Dices of the same kind
class DiceSet: Codable, NSCopying {
    
    var faces: Int {
        didSet {
            if faces < 2  {
                faces = 2
            } else if faces > 50 {
                faces = 50
            }
        }
    }
    
    var quantity: Int {
        didSet {
            if quantity < 1  {
                quantity = 1
            }
        }
    }
    
    init(faces: Int = 6, quantity: Int = 1) {
        self.faces = faces
        self.quantity = quantity
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return DiceSet(faces: faces, quantity: quantity)
    }
}
