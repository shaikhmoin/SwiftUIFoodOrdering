//
//  GlobalAler.swift
//  RestaurantFoodApp
//
//  Created by macOS on 24/08/23.
//

import SwiftUI

struct GlobalAlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
}

class GlobalAlertManager: ObservableObject {
    @Published var alertItem: GlobalAlertItem? = nil
    
    func showAlert(title: String, message: String) {
        alertItem = GlobalAlertItem(title: title, message: message)
    }
}
