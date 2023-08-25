//
//  StorekitManager.swift
//  RestaurantFoodApp
//
//  Created by macOS on 24/08/23.
//

import StoreKit
import SwiftUI

class StorekitManager: NSObject, ObservableObject {
    
//    private let productIds = ["com.lifetime.product", "com.weekly.product", "com.everytimeconsumable.product" , "com.yearly.product", "com.weeklyNonRenew.product" , "com.yearlyNonRenew.product"]
    private let productIds = ["com.nonconsumablelifetime.product", "com.consumableonetime.product" , "com.autorenewable.product", "com.nonautorenewable.product"]
    
    @Published private(set) var products: [Product] = []
    private var productsLoaded = false
    
    @Published private(set) var purchasedProductIDs = Set<String>()
    
    var hasUnlockedPro: Bool {
        return !self.purchasedProductIDs.isEmpty
    }
    
    //Store selected purchase subscription
    static let userDefaults = UserDefaults(suiteName: "group.your.app")!

    @AppStorage("hasPro", store: userDefaults)
    var hasPro: Bool = false
    
//    init(storeKitManager: StorekitManager) {
//        super.init()
//        SKPaymentQueue.default().add(self)
//    }
    
    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
    }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        
        switch result {
        case let .success(.verified(transaction)):
            // Successful purhcase
            
            await transaction.finish()
            await self.updatePurchasedProducts()
            
        case let .success(.unverified(_, error)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            break
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            break
        case .userCancelled:
            // ^^^
            break
        @unknown default:
            break
        }
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
        self.hasPro = !self.purchasedProductIDs.isEmpty //Store active purchases
        print(self.hasPro)
    }
}

//extension StorekitManager: SKPaymentTransactionObserver {
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//
//    }
//
//    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
//        return true
//    }
//}
