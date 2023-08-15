//
//  RestaurantFoodAppApp.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI

@main
struct RestaurantFoodAppApp: App {
    
    @StateObject private var vm = CartManager()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(vm) // Any child view will have access to this environment object
        }
    }
}
