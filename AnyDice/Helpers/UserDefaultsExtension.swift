//
//  UserDefaultsExtension.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-11-02.
//

import Foundation

/// required in order to write(read) Array<DiceSet> to UserDefaults
extension UserDefaults {
    
    func set<Element: Codable>(value: Element, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let element = try? JSONDecoder().decode(Element.self, from: data)
        return element
    }

}
