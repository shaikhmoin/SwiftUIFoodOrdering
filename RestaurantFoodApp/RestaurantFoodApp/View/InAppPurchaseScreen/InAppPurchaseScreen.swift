//
//  InAppPurchaseScreen.swift
//  RestaurantFoodApp
//
//  Created by macOS on 24/08/23.
//

import SwiftUI
import StoreKit //Storekit 2

enum PremiumPlan: String {
    case weeklyAuto = "weeklyAuto"
    case weeklyNonrenew = "weeklyNonrenew"
    case everytimeConsumable = "everytimeConsumable"
    case lifetimeNonConsumable = "lifetimeNonConsumable"
}

struct InAppPurchaseScreen: View {
    
//    @EnvironmentObject private var entitlementManager: EntitlementManager
    @EnvironmentObject private var purchaseManager: StorekitManager
    @ObservedObject var viewModel = SubscriptionViewModel()
    @State private var selectedPlan: PremiumPlan = .weeklyAuto
    @State private var selected: Bool = false

    var body: some View {
        
        //Dynamic Ui set as per subscription
//        NavigationView {
//            VStack {
//                Text("Choose a Subscription Plan")
//                    .font(.title)
//                    .padding()
//
//                ForEach(purchaseManager.products) { product in
//                    Button {
//                        Task {
//                            do {
//                                print(product)
//                                try await purchaseManager.purchase(product)
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    } label: {
////                        Text("\(product.displayPrice) - \(product.displayName)")
////                            .foregroundColor(.white)
////                            .padding()
////                            .background(.blue)
////                            .clipShape(Capsule())
//                        SubscriptionsView(title: product.displayName, price: product.displayPrice, myProduct: product)
//                    }
//                    //SubscriptionsView(product: product, purchaseAction: viewModel.purchase)
//                }
//
//                Spacer()
//            }
//            .navigationBarTitle("Subscription", displayMode: .inline)
//
//            .task {
//                Task {
//                    do {
//                        try await purchaseManager.loadProducts()
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
//        }
        
        
        NavigationView {
            VStack {
                Text("Choose a Subscription Plan")
                    .font(.title)
                    .padding()
                
                ForEach(purchaseManager.products) { product in
                    Button {
                        print(product.displayName)
                        
                        if product.displayName == "Weekly Autorenewable" {
                            selectedPlan = .weeklyAuto
                        } else if product.displayName == "Every Time Consumable Purchase" {
                            selectedPlan = .everytimeConsumable

                        } else if product.displayName == "Weekly Nonrenewable" {
                            selectedPlan = .weeklyNonrenew
                            
                        } else if product.displayName == "Life Time NonConsumable" {
                            selectedPlan = .lifetimeNonConsumable
                        }
//                        Task {
//                            do {
//                                print(product)
//                                try await purchaseManager.purchase(product)
//                            } catch {
//                                print(error)
//                            }
//                        }
                    } label: {
                        
                        ZStack {
                            HStack(spacing: 16) {
                                if selectedPlan == .weeklyAuto {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.orange)
                                } else {
                                    Image(systemName: "circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.orange)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(product.displayName)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.black)
                                    
                                    Text(product.displayPrice)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                           
                            .frame(maxWidth: .infinity)
                            .frame(height: 80)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.blue, lineWidth: 4)
                            )
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                            
//                            VStack {
//                                HStack {
//                                    Spacer()
//                                    Text("Save 40%")
//                                        .font(.system(size: 14, weight: .medium))
//                                        .padding(8)
//                                        .background(.orange)
//                                        .foregroundColor(.white)
//                                        .cornerRadius(6)
//                                        .opacity(1)
//                                }.padding(.horizontal, 40).padding(.top, -22)
//                                Spacer()
//                            }
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 80)
                        }
                    }
                }
                
                Button {
                    // TODO: action
                } label: {
                    Text("Continue")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }
                Spacer()
            }
                
            .navigationBarTitle("Subscription", displayMode: .inline)
            
            .task {
                Task {
                    do {
                        try await purchaseManager.loadProducts()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        //Static Ui setup

//        VStack(spacing: 20) {
//            //            if purchaseManager.hasUnlockedPro {
//            if purchaseManager.hasPro {
//
//                Text("Thank you for purchasing pro!")
//            } else {
//                Text("Products")
//                ForEach(purchaseManager.products) { product in
//                    Button {
//                        Task {
//                            do {
//                                print(product)
//                                try await purchaseManager.purchase(product)
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    } label: {
//                        Text("\(product.displayPrice) - \(product.displayName)")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(.blue)
//                            .clipShape(Capsule())
//                    }
//                }
//
//                Button {
//                    Task {
//                        do {
//                            try await AppStore.sync()
//                        } catch {
//                            print(error)
//                        }
//                    }
//                } label: {
//                    Text("Restore Purchases")
//                }
//            }
//        }.task {
//            Task {
//                do {
//                    try await purchaseManager.loadProducts()
//                } catch {
//                    print(error)
//                }
//            }
//        }
    }
}

struct InAppPurchaseScreen_Previews: PreviewProvider {
    static var previews: some View {
        InAppPurchaseScreen()
    }
}
