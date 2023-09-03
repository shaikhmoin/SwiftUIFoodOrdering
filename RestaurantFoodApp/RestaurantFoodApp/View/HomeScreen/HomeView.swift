//
//  HomeView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import UIKit
import Foundation
import SwiftUI

struct HomeView: View {
    
//    @Binding var loggedIn: Bool //For login-logout
    @EnvironmentObject var vm: CartManager
    @EnvironmentObject private var session: SessionManager
    @StateObject var viewModel: LoginViewModel
    @State private var isTabBarHidden = false

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    SearchBar()
                    
                    VStack {
                        
                        //Trending Week view
                        HStack {
                            Text("Trending this week")
                                .font(.headline)
                                .fontWeight(.regular)
                            
                            Spacer()
                            
                            Button {
                                print("View all click")
                            } label: {
                                Text("View all >")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(testTrendingData) { meals in
                                    NavigationLink(
                                        destination: MealDetails(mealDetails: meals).environmentObject(vm)
                                            .navigationBarHidden(true),
                                        label: {
                                            TrendingWeekView(trendingMeal: meals)
                                                .background(Color.white)
                                                .cornerRadius(20)
                                                .shadow(radius: 1)
                                        })
                                }
                                .padding(.bottom, 10)
                                .padding(.leading, 30)
                            }
                        }
                        
                        //Categories View
                        HStack {
                            Text("Categories")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button {
                                print("View all click")
                            } label: {
                                Text("View all >")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        
                        CategoriesView()
                        
                        //Our picks View
                        HStack {
                            Text("Our Picks")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button {
                                print("View all click")
                            } label: {
                                Text("View all >")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(testOurPicksData) { picks in
                                    NavigationLink(
                                        destination: SplashView(),
                                        label: {
                                            OurPicksView(ourPickesDT: picks)
                                        })
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    .padding(.top, -20)
                }
            }
            .background(.white)
            .ignoresSafeArea()
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
            .onAppear {
                viewModel.getExistingUser(completion: { result in
                    
                    switch result {
                    case .success(let message):
                        print("Existing user data: \(message)")
                        
                    case .failure(let error):
                        print("No existing user found: \(error)")
                    }
                })
                isTabBarHidden = true // Hide the tab bar
                UITabBar.appearance().isHidden = false
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let loginViewModel = LoginViewModel() // Declare the variable
        HomeView(viewModel: loginViewModel)
    }
    // we show the simulated view, not the BoolButtonView itself
    //    static var previews: some View {
    //        OtherView()
    //            .preferredColorScheme(.light)
    //    }
    //
    //    // nested OTHER VIEW providing the one value for binding makes the trick
    //    private struct OtherView : View {
    //
    //        @State var providedValue : Bool = false
    //
    //        var body: some View {
    //            HomeView(loggedIn: $providedValue)
    //        }
    //    }
}

struct SearchBar: View {
    
    @State var search = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.2980392157, blue: 0.262745098, alpha: 0.7016307805)), Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)*0.25, alignment: .bottom)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Deliver To")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
//                    Spacer()
                    
//                    Button(action: {}) {
//                        Image("filter")
//                            .font(.system(size: 26, weight: .heavy))
//                            .foregroundColor(.white)
//                    }
                }
                .padding(.bottom)
                .foregroundColor(.white)
               
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    VStack (spacing: 0){
                        HStack {
                            DropDown().offset(y: -18)
                        }
                    }.zIndex(1)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.title)
                            .padding(.leading)
                        
                        TextField("Search...", text: $search)
                            .font(.subheadline)
                    }
                    
                    .frame(width: (UIScreen.main.bounds.width) * 0.92, height: 45)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .shadow(radius: 1)
                }
            }
            .padding()
            .padding(.top, 20)
        }
    }
}
