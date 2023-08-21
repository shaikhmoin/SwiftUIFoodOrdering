//
//  RestaurantFoodAppApp.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI

@main
struct RestaurantFoodAppApp: App {
    
    @StateObject private var session = SessionManager()
    @StateObject private var cart = CartManager()
    @State var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    var body: some Scene {
        WindowGroup {
            
            //            switch session.currentState {
            //            case .loggedIn:
            //                SplashView()
            //                    .transition(.opacity)
            //                    .environmentObject(session)
            //
            //            default:
            //                NavigationView {
            //                    HomeView()
            //                        .transition(.opacity)
            //                }
            //            }
            
            if isLoggedIn == true {
                //                NavigationView {
                //                    HomeView()
                //                        .transition(.opacity)
                //                }
                
                TabbarView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .environmentObject(cart)
                    .environmentObject(session)
                
            } else {
                SplashView()
                    .transition(.opacity)
                    .environmentObject(cart)
                    .environmentObject(session)
            }
        }
    }
}
