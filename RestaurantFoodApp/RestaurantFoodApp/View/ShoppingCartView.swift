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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .padding(.leading, 10)
                    }
                    
                    Text("Shopping Cart")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .padding([.top], 50)
            
            HStack {
                Spacer()
                Text("Total: $\(String(format: "%.2f", cart.totalCost()))")
                    .font(.title)
                    .bold()
                Spacer()
            }
            
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
            .shadow(radius: 3)
            
            HStack(spacing: 10) {
                Button(action: {
                    cart.removeAll()
                }) {
                    Text("Clear Cart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.6))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    
                }) {
                    Text("Checkout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.6))
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 50)
        }
        
        .background(.blue.opacity(0.4))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
