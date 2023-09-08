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
    @StateObject var viewModelProductService: ProductService

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
                            
//                            Button {
//                                print("View all click")
//                            } label: {
//                                Text("View all >")
//                                    .foregroundColor(.red)
//                            }
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
                            .padding(.trailing, 30)
                        }
                        
                        //Categories View
                        HStack {
                            Text("Categories")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Spacer()
         
//                            Button(action: {
//                                // Action to perform when the button is tapped
//                            }) {
//                                NavigationLink(
//                                    destination: CategoryView().environmentObject(vm)
//                                ) {
//                                    Text("View all >")
//                                        .foregroundColor(.red)
//                                }
//                            }
                        }
                        .padding()
                        
                        CategoriesView()
                        
                        //Our picks View
                        HStack {
                            Text("Our Picks")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
//                            Button {
//                                print("View all click")
//                            } label: {
//                                Text("View all >")
//                                    .foregroundColor(.red)
//                            }
                        }
                        .padding()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
//                                ForEach(testOurPicksData) { picks in
//                                    NavigationLink(
//                                        destination: SplashView(),
//                                        label: {
//                                            OurPicksView(ourPickesDT: picks)
//                                        })
//                                    .buttonStyle(PlainButtonStyle())
//                                }
                                
                                ForEach(testTrendingData) { meals in
                                    NavigationLink(
                                        destination: MealDetails(mealDetails: meals).environmentObject(vm)
                                            .navigationBarHidden(true),
                                        label: {
                                            OurPicksView(ourPicksMeal: meals)
                                        })
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
                
                let product1 = FoodProduct(categoryID: "1", categoryName: "Pizza", name: "Veg Cheese Pizza", description: "Hot and spicy", price: 12.00, imageURL: "")
                let product2 = FoodProduct(categoryID: "1", categoryName: "Pizza", name: "Chicken Cheese Pizza", description: "Hot and spicy", price: 15.00, imageURL: "")
                let product3 = FoodProduct(categoryID: "2", categoryName: "Burger", name: "Double Dacker Burger", description: "Best seller", price: 20.00, imageURL: "")

                viewModelProductService.addProduct(product: product1)
                viewModelProductService.addProduct(product: product2)
                viewModelProductService.addProduct(product: product3)
                
                viewModelProductService.getProductsByCategory(categoryID: "1") { products in
                    // Use the retrieved products in your SwiftUI view
                    print(products)
                    print(products.count)
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .toolbar(.visible, for: .tabBar)
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let loginViewModel = LoginViewModel() // Declare the variable
        let productServiceViewModel = ProductService() // Declare the variable

        HomeView(viewModel: loginViewModel, viewModelProductService: productServiceViewModel)
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

struct OrderNowCard: View {
    
    var body : some View {
        HStack(spacing:100){
            VStack(alignment:.leading, spacing: 10){
                Text("The Fastes In")
                    .bold()
                HStack{
                    Text("Delivery")
                        .bold()
                    Text("Food")
                        .foregroundColor(.pink)
                        .bold()
                }
                // make it a button
                Text("Order Now")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.pink)
                    .cornerRadius(20)
            }
            .padding()
            Image("deleviry")
                .resizable()
                .frame(width: 150, height: 150)
            
        }
        .background(Color("lightyellow"))
        .cornerRadius(15)
        .padding(.top)
    }
}
