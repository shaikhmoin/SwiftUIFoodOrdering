//
//  HomeViewModel.swift
//  RestaurantFoodApp
//
//  Created by macOS on 15/08/23.
//

import SwiftUI

class CartManager: ObservableObject {
    
//    @Published var cartItems: [CartItem] = []
    @Published var cartItems: [CartItem] = []

    func addToCart(product: TrendingCard, Qty: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
            print(cartItems[index])
        } else {
            print(cartItems)
            cartItems.append(CartItem(product: product, quantity: 1)) // Use the standard initializer
            print(cartItems)
        }
    }
    
    func upodateInCart(product: TrendingCard, Qty: Int, increment : Bool) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            print(cartItems)
            print(cartItems[index])
            
            if increment {
                cartItems[index].quantity += 1
                
            } else {
                cartItems[index].quantity -= 1
            }
            print(cartItems)
            print(cartItems[index])
            
        } else {
            print(cartItems)
        }
    }
    
    func removeFromCart(cartItem: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
            cartItems.remove(at: index)
        }
    }
    
    func removeAll() {
        cartItems.removeAll()
    }
    
    func totalCost() -> Double {
        return cartItems.reduce(0.0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
} 
