//
//  SplashView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    @EnvironmentObject var sessionManager:SessionManager
    
    var body: some View {
        
        ZStack {
            //            Color("themecolor")
            
            if self.isActive {

                let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: SessionManager.userDefaultsKey.hasSeenOnboarding)
                if hasCompletedOnboarding {
                    let hasCompletedSignin = UserDefaults.standard.bool(forKey: SessionManager.userDefaultsKey.hasSeenSingin)
                    if hasCompletedSignin {
                        TabbarView()
                            .environmentObject(sessionManager)
                            .transition(.opacity)
                        
                    } else {
                        NavigationView {
                            
                            let loginViewModel = LoginViewModel() // Declare the variable
                            LoginView(viewModel: loginViewModel)
                                .environmentObject(sessionManager)
                                .transition(.opacity)
                        }
                    }
                    
                } else {
                    OnboardingView(action: sessionManager.completeOnboarding).environmentObject(sessionManager)
                }
                
                
            } else {
                Image("splashimage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        //        .background(Color("themecolor"))
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
