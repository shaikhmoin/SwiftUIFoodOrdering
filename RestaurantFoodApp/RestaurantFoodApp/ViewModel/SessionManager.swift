//
//  SessionManager.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum CurrentState {
        case loggedIn
        case loggedout
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func signIn() {
        currentState = .loggedIn
    }
    
    func signOut() {
        currentState = .loggedout
    }
}

