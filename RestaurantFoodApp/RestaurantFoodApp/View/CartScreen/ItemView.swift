//
//  ItemView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 16/08/23.
//

import SwiftUI

struct ItemView: View {
    
    @EnvironmentObject private var cart: CartManager
    @State private var stepperValue = 1
    var items: CartItem
    var isScreen: String = ""
//    @State var itemsCopy : CartItem //Another method of getting data

    var body: some View {
        HStack {
            Image(items.product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(items.product.title)
                Text("$\(String(format: "%.2f", items.product.price))")
                    .foregroundColor(.secondary)
            }
            
            if isScreen == "Addtocart" {
                Stepper("\(stepperValue)",
                        onIncrement: {
                    stepperValue += 1
                    print(stepperValue)
                    print(items.quantity)
                    
                    cart.upodateInCart(product: items.product, Qty: stepperValue, increment: true)
                    
                }, onDecrement: {
                    print(stepperValue)
                    print(items.quantity)
                    
                    if items.quantity <= 1 {
                        stepperValue = 1
                    } else {
                        stepperValue -= 1
                        cart.upodateInCart(product: items.product, Qty: stepperValue, increment: false)
                    }
                })
                .foregroundColor(.black)
                .background(Color.white)
                .frame(width: 80)
                
                Text("\(items.quantity)")
                    .font(.headline)
                    .padding()
            } else {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView(items: <#Binding<CartItem>#>)
//    }
//}
