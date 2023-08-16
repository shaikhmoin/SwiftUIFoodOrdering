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
            
            Text("Total: $\(String(format: "%.2f", cart.totalCost()))")
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
                            
                            cart.upodateInCart(product: product.product, Qty: stepperValue, increment: true)
                            
                        }, onDecrement: {
                            stepperValue -= 1
                            
                            cart.upodateInCart(product: product.product, Qty: stepperValue, increment: false)

                        })
                        .foregroundColor(.black)
                        .background(Color.white)
                        .frame(width: 100)
                        

                        Text("\(product.quantity)")
                            .font(.headline)
                            .padding()
                    }
                    
                }
                .onDelete { indexSet in
                    let indexPath = IndexPath(indexes: indexSet)
                    print(indexPath)
                    print(indexPath[0])

                    //Delete selected cartitem data
                    cart.removeFromCart(cartItem: cart.cartItems[indexPath[0]])
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
