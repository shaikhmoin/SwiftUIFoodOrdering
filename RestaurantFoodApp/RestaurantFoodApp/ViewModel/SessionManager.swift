//
//  SessionManager.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum userDefaultsKey {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let hasSeenSingin = "hasSeenSingin"
        static let hasUserEmail = "hasUserEmail"
    }
    
    enum CurrentState {
        case loggedIn
        case loggedout
        case onboarding
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func signIn() {
        currentState = .loggedIn
        UserDefaults.standard.set(true, forKey: userDefaultsKey.hasSeenSingin)
    }
    
    func signOut() {
        currentState = .loggedout
        //        UserDefaults.standard.set(false, forKey: userDefaultsKey.hasSeenOnboarding)
        UserDefaults.standard.set(false, forKey: userDefaultsKey.hasSeenSingin)
        UserDefaults.standard.set("", forKey: userDefaultsKey.hasUserEmail)

    }
    
    func completeOnboarding() {
        currentState = .loggedout
        UserDefaults.standard.set(true, forKey: userDefaultsKey.hasSeenOnboarding)
    }
    
    func configureCurrentState() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: userDefaultsKey.hasSeenOnboarding)
        currentState = hasCompletedOnboarding ? .loggedout : .onboarding
    }
}
