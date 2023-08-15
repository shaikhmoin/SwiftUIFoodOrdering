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
    
    @Binding var loggedIn: Bool //For login-logout
    
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
                                        destination: MealDetails(mealDetails: meals)
                                            .navigationBarHidden(true),
                                        label: {
                                            TrendingWeekView(trendingMeal: meals)
                                                .background(Color.white)
                                                .cornerRadius(20)
                                                .shadow(radius: 1)
                                        })
                                    .buttonStyle(PlainButtonStyle())
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
                        
                        // Categories View
                        HStack(spacing: 15) {
                            ForEach(1 ..< 5) { i in
                                VStack {
                                    Image("categ-\(String(i))")
                                    Text(FoodTypes[Int(i)-1])
                                        .font(.subheadline)
                                        .bold()
                                }
                                .onTapGesture {
                                    print("Test cat")
                                }
                                .frame(width: 80, height: 100, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 1)
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(3 ..< 7) { i in
                                VStack {
                                    Image("categ-\(String(i))")
                                    Text(FoodTypes[Int(i)-1])
                                        .font(.subheadline)
                                        .bold()
                                }
                                .onTapGesture {
                                    print("Test cat")
                                }
                                .frame(width: 80, height: 100, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 1)
                            }
                        }
                        
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
                    .padding(.top, -30)
                }
            }
            .background(.white)
            .ignoresSafeArea()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    // we show the simulated view, not the BoolButtonView itself
    static var previews: some View {
        OtherView()
            .preferredColorScheme(.light)
    }
    
    // nested OTHER VIEW providing the one value for binding makes the trick
    private struct OtherView : View {
        
        @State var providedValue : Bool = false
        
        var body: some View {
            HomeView(loggedIn: $providedValue)
        }
    }
}

struct SearchBar: View {
    
    @State var search = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)*0.25, alignment: .center)
            
            VStack {
                HStack {
                    Text("Browse")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    Text("Filter")
                        .font(.headline)
                        .fontWeight(.regular)
                }
                .padding()
                .foregroundColor(.white)
                
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
            }
        }
    }
}
