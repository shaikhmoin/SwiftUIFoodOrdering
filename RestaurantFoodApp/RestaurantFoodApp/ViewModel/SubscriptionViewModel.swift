//
//  SubscriptionViewModel.swift
//  RestaurantFoodApp
//
//  Created by macOS on 25/08/23.
//

import Foundation
import StoreKit
import SwiftUI

class SubscriptionViewModel: ObservableObject {
    @Published var products: [SKProduct] = []

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        let productIdentifiers: Set<String> = ["com.nonconsumablelifetime.product", "com.consumableonetime.product" , "com.autorenewable.product", "com.nonautorenewable.product"]
        
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
//        request.delegate = self
        request.start()
    }

    func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

//extension SubscriptionViewModel: SKProductsRequestDelegate {
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        self.products = response.products
//    }
//}
