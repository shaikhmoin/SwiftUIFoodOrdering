//
//  SplashView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    @State var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

    var body: some View {
        
        ZStack {
            //            Color("bg")
            
            if self.isActive {
                //                if isLoggedIn {
                //                    HomeView(loggedIn: $isLoggedIn)
                //                } else {
                OnboardingView(loggedIn: $isLoggedIn)
                //                }
                               
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
        //        .background(Color("bg"))
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
