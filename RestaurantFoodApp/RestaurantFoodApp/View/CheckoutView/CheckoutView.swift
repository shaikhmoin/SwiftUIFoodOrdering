//
//  CheckoutView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 31/08/23.
//

import SwiftUI
import Stripe

struct CheckoutView: View {
    
    @EnvironmentObject private var cart: CartManager
    @State private var message: String = ""
    @State private var isSuccess: Bool = false
    @State private var paymentMethodParams: STPPaymentMethodParams?
    let paymentGatewayController = PaymentGatewayController()
    
    private func pay() {
        
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.submitPayment(intent: paymentIntentParams) { status, intent, error in
            
            switch status {
            case .failed:
                message = "Failed"
            case .canceled:
                message = "Cancelled"
            case .succeeded:
                message = "Your payment has been successfully completed!"
            }
            
        }
    }
    
    var body: some View {
        VStack {
            List {
                
                ForEach(cart.cartItems) { item in
                    HStack {
//                        Text(item.photo)
                        Text(item.product.title + "(\(String(format: "%.0f", item.product.price))" + " × \(item.quantity))")
                        Spacer()
                        Text("$\(Int(item.product.price) * Int(item.quantity))")
                    }
                }
                
                HStack {
                    Spacer()
                    Spacer()
//                    Text("Total \(formatPrice(cart.cartTotal) ?? "")")
                    Text("Total: $\(String(format: "%.2f", cart.totalCost()))")
                }
                
                Section {
                    // Stripe Credit Card TextField Here
                    STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
                } header: {
                    Text("Payment Information")
                }
                
                HStack {
                    Spacer()
                    Button("Pay") {
                        pay()
                    }.buttonStyle(.plain)
                    Spacer()
                }
                
                Text(message)
                    .font(.headline)
            }
            
            NavigationLink(isActive: $isSuccess, destination: {
                //Confirmation()
            }, label: {
                EmptyView()
            })
            
            .navigationTitle("Checkout")
        }
    }
    
    func formatPrice(_ price: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: price))
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView().environmentObject(CartManager())
        }
    }
}
