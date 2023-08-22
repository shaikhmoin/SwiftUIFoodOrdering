//
//  LoginViewModel.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
}
