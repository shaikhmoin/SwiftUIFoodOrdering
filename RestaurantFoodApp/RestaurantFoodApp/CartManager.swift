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

//    func addToCart(product: TrendingCard) {
//        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
//            cartItems[index].quantity += 1
//            print(cartItems[index])
//        } else {
//            print(cartItems)
//            cartItems.append(CartItem(product: product, quantity: 1))
//            print(cartItems)
//        }
//    }
    
    func addToCart(product: TrendingCard, Qty: Int) {
        print(cartItems)
        cartItems.append(CartItem(product: product, quantity: Qty + 1))
        print(cartItems)
    }
    
//    func addToCart(product: TrendingCard) {
//        products.append(product)
//        print(products)
//    }
    
//    func addToCartCard(item: TrendingCard)  {
//        //Checking it is added...
//
//        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
//        if item.isAdded {
//            //removing from list
//            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
//            return
//        }
//        //else adding
//        self.cartItems.append(CartItem(product: item, quantity: 1))
//    }
//
//    func getIndex(item: TrendingCard, isCartIndex: Bool) -> Int {
//        let index = self.items.firstIndex { (item1) -> Bool in
//            return item.id == item1.id
//        } ?? 0
//
//        let cartIndex = self.cartItems.firstIndex { (item1) -> Bool in
//            return item.id == item1.product.id
//        } ?? 0
//
//        return isCartIndex ? cartIndex : index
//    }
    
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
