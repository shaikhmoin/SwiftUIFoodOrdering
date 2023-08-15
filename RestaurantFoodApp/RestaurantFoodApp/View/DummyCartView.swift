//
//  DummyCartView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 15/08/23.
//

import SwiftUI

class Cart: ObservableObject {
    @Published var products: [Productss] = []
    
    func addToCart(product: Productss) {
        products.append(product)
        print(products)
    }
    
    func removeFromCart(product: Productss) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
        }
    }
}

struct Productss: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

struct ContentViews: View {
    @StateObject private var cart = Cart()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Products")
                    .font(.title)
                    .padding()
                
                List {
                    ForEach(products) { product in
                        ProductRowView(product: product)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                NavigationLink(destination: CartView()) {
                    Text("Go to Cart (\(cart.products.count))")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarTitle("Shopping Cart")
        }
    }
    
    var products: [Productss] {
        [
            Productss(name: "Product 1", price: 9.99),
            Productss(name: "Product 2", price: 19.99),
            Productss(name: "Product 3", price: 14.99),
        ]
    }
}

struct ProductRowView: View {
    let product: Productss
    @EnvironmentObject private var cart: Cart
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text("$\(product.price)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                print(product)
                cart.addToCart(product: product)
            }) {
                Image(systemName: "cart.badge.plus")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 8)
    }
}

struct CartView: View {
    @EnvironmentObject private var cart: Cart
    
    var body: some View {
        VStack {
            Text("Cart")
                .font(.title)
                .padding()
            
            List {
                ForEach(cart.products) { product in
                    Text(product.name)
                }
                .onDelete { indexSet in
                    cart.products.remove(atOffsets: indexSet)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            Button(action: {
                cart.products.removeAll()
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
}

struct ContentViews_Previews: PreviewProvider {
    static var previews: some View {
        ContentViews()
    }
}
