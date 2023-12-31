//
//  Persistence.swift
//  RestaurantFoodApp
//
//  Created by macOS on 29/08/23.
//

import Foundation

class Persistence {
    static let consumablesCountKey = "consumablesCount"
    private static let storage = UserDefaults()
    
    static func increaseConsumablesCount() {
        let currentValue = storage.integer(forKey: Persistence.consumablesCountKey)
        storage.set(currentValue + 1, forKey: Persistence.consumablesCountKey)
    }
}
