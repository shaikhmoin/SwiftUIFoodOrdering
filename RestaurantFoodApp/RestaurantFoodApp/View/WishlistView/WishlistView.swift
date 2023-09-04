//
//  WishlistView.swift
//  RestaurantFoodApp
//
//  Created by iMac on 03/09/23.
//

import SwiftUI

struct WishlistView: View {

    @EnvironmentObject var cart: CartManager
    
    @State var categoryIndex = 0
    @State var text = ""
    
    var columns = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    SearchBar()
                    
                    if cart.wishlistItems.count > 0 {
                        
                        ForEach(cart.wishlistItems) { product in
                            NavigationLink(
                                destination: MealDetails(mealDetails: product.product).environmentObject(cart)
                                    .navigationBarHidden(true),
                                label: {
                                    //                                        ProductRow(product: product)
                                    ItemView(items: product, isScreen: "Wishlist") //Items view
                                })
                        }
                        
                    } else {
                        Text("Your cart is empty.")
                    }
                }
                .background(.white)
                .ignoresSafeArea()
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
            }
        }
       
        .onAppear {
            print(cart.wishlistItems)
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: CartItem
    
    var body: some View {
        HStack(spacing: 20) {
            Image(product.product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.product.title)
                    .bold()

                Text("$\(product.product.price)")
            }
            
            Spacer()

//            Image(systemName: "trash")
//                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
//                .onTapGesture {
//                   // cartManager.removeFromCart(product: product)
//                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
