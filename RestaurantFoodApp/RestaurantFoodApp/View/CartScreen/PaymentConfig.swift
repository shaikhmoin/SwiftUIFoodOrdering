//
//  PaymentConfig.swift
//  RestaurantFoodApp
//
//  Created by macOS on 31/08/23.
//

import Foundation

class PaymentConfig {
    
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    
    private init() { }
}
