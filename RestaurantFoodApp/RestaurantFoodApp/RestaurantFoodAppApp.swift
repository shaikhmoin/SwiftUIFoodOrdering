//
//  RestaurantFoodAppApp.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct RestaurantFoodAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var session = SessionManager()
    @StateObject private var cart = CartManager()
    
    
    var body: some Scene {
        WindowGroup {
            
            //New
            ZStack {
                switch session.currentState {
                case .loggedIn:
                    TabbarView()
                        .environmentObject(session)
                        .environmentObject(cart)
                        .transition(.opacity)
                    
                case .loggedout:
                    NavigationView {
                        let loginViewModel = LoginViewModel() // Declare the variable
                        LoginView(viewModel: loginViewModel)
                            .environmentObject(session)
                            .transition(.opacity)
                    }
                    
                case .onboarding:
                    NavigationView {
                        OnboardingView(action: session.completeOnboarding).navigationBarHidden(true)
                    }
                    
                default:
                    SplashView()
                        .environmentObject(session)
                        .transition(.opacity)
                }
            }
            
            .animation(.easeOut, value: session.currentState)
            // .onAppear(perform: session.configureCurrentState) //Login Or onboarding (Only once onboarding open and then set as useerdefault)           
        }
    }
}
