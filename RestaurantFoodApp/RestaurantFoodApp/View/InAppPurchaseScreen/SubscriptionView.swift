//
//  SubscriptionOptionView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 25/08/23.
//

import SwiftUI
import StoreKit

struct SubscriptionsView: View {
    
    var title: String
    var price: String
    var myProduct: Product
    
    @EnvironmentObject private var purchaseManager: StorekitManager

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(price)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                // Handle subscription selection
                Task {
                    do {
                        print(myProduct)
                        try await purchaseManager.purchase(myProduct)
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text("Subscribe")
                    .frame(width: 120, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

//struct SubscriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubscriptionView(title: "1 Year", price: "2.99")
//    }
//}
