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
    
    @EnvironmentObject private var cart: CartManager
    @State private var quantity = 0
    @State private var stepperValue = 1

    var body: some View {
        VStack {
            Text("Cart")
                .font(.title)
                .padding()
            
            List {
                ForEach(cart.cartItems) { product in
                    
                    HStack {
                        Image(product.product.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(product.product.title)
                            Text("$\(String(format: "%.2f", product.product.price))")
                                .foregroundColor(.secondary)
                        }
 
                        Stepper("\(stepperValue)",
                                onIncrement: {
                            stepperValue += 1
                            
                        }, onDecrement: {
                            stepperValue -= 1
                        })
                        .foregroundColor(.black)
                        .background(Color.white)
                        .frame(width: 100)
                        

                        Text("\(stepperValue)")
                            .font(.headline)
                            .padding()
                        
//                        Stepper(quantity == 0 ? String(product.quantity) : String(quantity),
//                                onIncrement: {
//                            quantity = product.quantity
//                            quantity += 1
//                            print(quantity)
//
//                        }, onDecrement: {
//                            quantity = product.quantity
//                            quantity -= 1
//                            print(quantity)
//                        })
//                        .foregroundColor(.black)
//                        .background(Color.white)
//                        .frame(width: 100)
                        
                        // Button("Remove") {
                        //                            cartManager.removeFromCart(cartItem: cartItem)
                        //}
                    }
                }
                .onDelete { indexSet in
                    //cart.products.remove(atOffsets: indexSet)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            Button(action: {
                //cart.products.removeAll()
            }) {
                Text("Clear Cart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitle("Shopping Cart")
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
