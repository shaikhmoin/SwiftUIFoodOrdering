//
//  TabbarView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI

struct TabbarView: View {
    
    @State private var selectedTabIndex = 0
    @State var providedValue : Bool = true
    @State private var show = false
    //    @ObservedObject var cartManager: CartManager
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        
        TabView(selection: $selectedTabIndex) {
            
//            HomeView(loggedIn: $providedValue)
            HomeView()

                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            VStack {
                Text("Category")
            }
            .tabItem {
                Label("Category", systemImage: "list.clipboard")
            }
            .tag(1)
            
            Text("Wishlist")
                .tabItem {
                    Label("Wishlist", systemImage: "heart")
                }
                .tag(2)
            
            ShoppingCartView(show: $show)
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .tag(3)
            //                .badge(12)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "apple.logo")
                }
                .tag(4)
        }
        .accentColor(Color.blue)
        .onAppear() {
            //            UITabBar.appearance().barTintColor = .yellow
        }
        .navigationBarHidden(true)
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
