//
//  WishlistView.swift
//  RestaurantFoodApp
//
//  Created by iMac on 03/09/23.
//

import SwiftUI

struct WishlistView: View {
    
    @EnvironmentObject var cart: CartManager

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
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
