//
//  RestaurantFoodAppApp.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI
import FirebaseCore
import Stripe

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct RestaurantFoodAppApp: App {
    
    init() {
        StripeAPI.defaultPublishableKey = "pk_test_51Nl4ZQSCS3n4ntHszV0rkrH4LjLcbEjP95OnzUdzCq2wSgLL3fyhJFYXmc5coquzraE4GpyqIGq7X0wETgZ3oxMb005NSd3Mo9"
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var session = SessionManager()
    @StateObject private var cart = CartManager()
    
    @StateObject private var purchaseManager = StorekitManager()
    
    var body: some Scene {
        WindowGroup {
            
//            InAppPurchaseScreen()
//                .environmentObject(purchaseManager)
//                .task {
//                    await purchaseManager.updatePurchasedProducts() //Check any subcription purchase by current Apple ID
//                }

            //New
            ZStack {
                switch session.currentState {
                case .loggedIn:
                    TabbarView()
                        .environmentObject(session)
                        .environmentObject(cart)
                        .environmentObject(purchaseManager)
                        .transition(.opacity)
                    
                case .loggedout:
                    NavigationView {
                        let loginViewModel = LoginViewModel() // Declare the variable
                        LoginView(viewModel: loginViewModel)
                            .environmentObject(session)
                            .environmentObject(purchaseManager)
                            .environmentObject(cart)
                            .transition(.opacity)
                    }
                    
                case .onboarding:
                    NavigationView {
                        OnboardingView(action: session.completeOnboarding).navigationBarHidden(true)
                    }
                    
                default:
                    SplashView()
                        .environmentObject(session)
                        .environmentObject(cart)
                        .environmentObject(purchaseManager)
                        .transition(.opacity)
                }
            }
//
//            .animation(.easeOut, value: session.currentState)
//            // .onAppear(perform: session.configureCurrentState) //Login Or onboarding (Only once onboarding open and then set as useerdefault)
        }
    }
}
