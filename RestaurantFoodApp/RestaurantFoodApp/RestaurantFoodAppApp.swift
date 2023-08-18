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
    @StateObject private var session = SessionManager()
    @State var isActive:Bool = true

//    @StateObject private var vm = Cart()

    var body: some Scene {
        WindowGroup {
            
            switch session.currentState {
            case .loggedIn:
//                HomeView(loggedIn: $isActive)
                HomeView()
                    .environmentObject(vm) // Any child view will have access to this environment object
                    .transition(.opacity)
            default:
                SplashView()
                    .transition(.opacity)
                    .environmentObject(vm) // Any child view will have access to this environment object
            }
        }
    }
}
