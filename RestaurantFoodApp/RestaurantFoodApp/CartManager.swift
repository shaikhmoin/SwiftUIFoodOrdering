//
//  HomeViewModel.swift
//  RestaurantFoodApp
//
//  Created by macOS on 15/08/23.
//

import SwiftUI

class CartManager: ObservableObject {
    
//    @Published var items: [TrendingCard] = []
    @Published var cartItems: [CartItem] = []
//    @Published var products: [TrendingCard] = []

    func addToCart(product: TrendingCard, Qty: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
            print(cartItems[index])
        } else {
            print(cartItems)
            cartItems.append(CartItem(product: product, quantity: 1))
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
            //cartItems.append(CartItem(product: product, quantity: 1))
           // print(cartItems)
        }
    }
    
    func calculateTotalPrice() -> String {
        
        var price : Float = 0
        
        cartItems.forEach { (item) in
            price += Float(item.quantity) * Float(truncating: item.product.price as NSNumber)
        }
        
        return getPrice(value: price)
    }
    
    func getPrice(value: Float) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func removeFromCart(cartItem: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
            cartItems.remove(at: index)
        }
    }
    
    func totalCost() -> Double {
        return cartItems.reduce(0.0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
} 
