//
//  ShoppingCartView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 15/08/23.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: TrendingCard
    var quantity: Int
}

struct ShoppingCartView: View {
    
//    @ObservedObject var cartManager: CartManager
    @EnvironmentObject var model: CartManager

    var body: some View {
        VStack {
            ForEach(model.cartItems) { item in
                HStack {
                    Image("categ-2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        Text("dddddd")
                        Text("$\(String(format: "%.2f", 25.00))")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("Qty: \(5)")
                    Button("Remove") {
                        //                            cartManager.removeFromCart(cartItem: cartItem)
                    }
                }
                .padding()
            }
        }
    }
    //                .navigationBarTitle("Cart")
    //                .navigationBarItems(trailing: Text("Total: $\(String(format: "%.2f", cartManager.totalCost()))"))
    
    //        List(cartManager.cartItems) { cartItem in
    //            HStack {
    //                Image("categ-2")
    //                    .resizable()
    //                    .aspectRatio(contentMode: .fit)
    //                    .frame(width: 60, height: 60)
    //
    //                VStack(alignment: .leading) {
    //                    Text(cartItem.product.title)
    //                    Text("$\(String(format: "%.2f", cartItem.product.price))")
    //                        .foregroundColor(.secondary)
    //                }
    //                Spacer()
    //                Text("Qty: \(cartItem.quantity)")
    //                Button("Remove") {
    //                    cartManager.removeFromCart(cartItem: cartItem)
    //                }
    //            }
    //            .padding()
    //        }
    //        .navigationBarTitle("Cart")
    //        .navigationBarItems(trailing: Text("Total: $\(String(format: "%.2f", cartManager.totalCost()))"))
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
