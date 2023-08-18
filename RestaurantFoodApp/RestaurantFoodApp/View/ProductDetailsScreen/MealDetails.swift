//
//  MealDetails.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import SwiftUI

struct MealDetails: View {
    
    @State var mealDetails : TrendingCard
    @State private var quantity = 0
    @State var heart = "heart.fill"
    @State private var isCartClick = false
    @State private var show = true

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var cart: CartManager
    @State var buttonTitle: String = "Add to Cart"
    @State var selection: Int? = nil

    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    ZStack {
                        HStack(alignment: .top) {
                            GeometryReader{reader in
                                Image(mealDetails.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(y: -reader.frame(in: .global).minY)
                                // going to add parallax effect....
                                    .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY + 300)
                            }
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.8))
                                    .clipShape(Circle())
                                    .padding(.trailing, 10)
                            }
                        }
                        .frame(height: 280)
                    }
                    
                    VStack(alignment: .leading,spacing: 15){
                        
                        Text(mealDetails.title)
                            .font(.system(size: 35, weight: .bold))
                        
                        HStack(spacing: 10){
                            
                            ForEach(0..<mealDetails.stars){_ in
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                        HStack {
                            Text(mealDetails.descrip)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.top,5)
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.spring(dampingFraction: 0.5)) {
                                    heart = "heart"
                                }
                            }, label: {
                                Image(systemName: heart)
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                                
                            })
                            .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        
                        Text("Description")
                            .font(.system(size: 25, weight: .bold))
                        
                        Text(mealDetails.longDescrip)
                            .padding(.top, 10)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack {
                            Text("Price ")
                                .font(.title3)
                                .bold()
                            Spacer()
                            
                            Text("$\(forTrailingZero(mealDetails.price))")
                                .font(.title2)
                                .bold()
                        }
                        .padding(.top, 10)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(20)
                    .offset(y: -35)
                })
                
                Spacer()
                
                HStack{
                    Spacer()
       
                    NavigationLink(destination: isCartClick == true ? ShoppingCartView(show: $show) : ShoppingCartView(show: $show)) {
                        Text((cart.cartItems.firstIndex(where: { $0.product.id == mealDetails.id }) != nil) ? buttonTitle : buttonTitle)

                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 100)
                            .background(Color.blue.opacity(0.9))
                            .cornerRadius(10)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        print("I am here in the action")
                        
                        if let index = cart.cartItems.firstIndex(where: { $0.product.id == mealDetails.id }) {
                            print("Match")
                            cart.addToCart(product: mealDetails, Qty: quantity)
                            isCartClick = false
                            
                        } else {
                            cart.addToCart(product: mealDetails, Qty: quantity)
                            isCartClick = true
                        }
                    })
                    
                    Spacer()
                }
                
                .edgesIgnoringSafeArea(.all)
                .background(Color.white.edgesIgnoringSafeArea(.all))
            }
        }
    }
    
    func forTrailingZero(_ temp: Double) -> String {
        var tempVar = String(format: "%g", temp)
        return tempVar
    }
}

struct MealDetails_Previews: PreviewProvider {
    static var previews: some View {
        //        MealDetails()
        MealDetails(mealDetails: testTrendingData[0])
    }
}