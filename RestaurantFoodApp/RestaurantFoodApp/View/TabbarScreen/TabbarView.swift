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
    @StateObject private var cart = CartManager()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        
        TabView(selection: $selectedTabIndex) {
            
            //            HomeView(loggedIn: $providedValue)
            NavigationView {
                HomeView(viewModel: LoginViewModel(),
                         viewModelProductService: ProductService())
                    .environmentObject(cart)
            }
            
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)
            
            CategoryView()
            
                .tabItem {
                    Label("Category", systemImage: "list.clipboard")
                }
                .tag(1)
            
            WishlistView()
                .environmentObject(cart)
            
                .tabItem {
                    Label("Wishlist", systemImage: "heart")
                }
                .tag(2)
            
            ShoppingCartView(show: $show)
                .environmentObject(cart)
            
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .tag(3)
            //                .badge(12)
            
            NavigationView {
                SettingsView(viewModel: LoginViewModel(), viewModelUserProfile: UserProfileViewModel())
            }
            
            .tabItem {
                Label("Settings", systemImage: "apple.logo")
            }
            .tag(4)
        }
        .accentColor(Color("themecolor"))
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
