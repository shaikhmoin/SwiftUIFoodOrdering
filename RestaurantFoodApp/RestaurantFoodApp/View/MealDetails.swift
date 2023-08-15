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
    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var cartManager = CartManager()
    @EnvironmentObject private var cart: CartManager

    var body: some View {
        
        if let index = cart.cartItems.firstIndex(where: { $0.product.id == mealDetails.id }) {
            EmptyView()

            //                cart.cartItems[index].quantity += 1
//            print(cart.cartItems)
//            print(cart.cartItems[index])
        } else {
            EmptyView()

//            print(cart.cartItems)
            //cart.cartItems.append(CartItem(product: product, quantity: 1))
            //print(cart.cartItems)
        }
        
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
                        
                        ForEach(1..<5){_ in
                            
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

//                    HStack(spacing: 30) {
//                        Text("Quantity ")
//                            .font(.title3)
//                            .bold()
//
//                        Stepper("",
//                                onIncrement: {
//                                    quantity+=1
//                                }, onDecrement: {
//                                    quantity-=1
//                                })
//                            .foregroundColor(.black)
//                            .background(Color.white)
//                            .frame(width: 100)
//
//                        Text(String(quantity+1))
//                            .font(.title2)
//                            .bold()
//
//                    }.padding(.top, 10)

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
                
                Button(action: {
                    cart.addToCart(product: mealDetails, Qty: quantity)
                    isCartClick.toggle()
                    
                    if !isCartClick {
                        
                    } else {
                        
                    }
                    
                }, label: {
                    Text(isCartClick ? "Go To Cart" : "Add to Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 100)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(10)
                })
                Spacer()
            }
//            .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

            .edgesIgnoringSafeArea(.all)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .onAppear(
//            if !showGreeting {
//                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                               showGreeting = true
//                           }
//                       }
          
//            if let index = cart.cartItems.firstIndex(where: { $0.product.id == mealDetails.id }) {
////                cart.cartItems[index].quantity += 1
//                print(cart.cartItems)
//                print(cart.cartItems[index])
//            } else {
//                print(cart.cartItems)
//                //cart.cartItems.append(CartItem(product: product, quantity: 1))
//                //print(cart.cartItems)
//            }
        )
    }
    
    func checkProd() {
        if let index = cart.cartItems.firstIndex(where: { $0.product.id == mealDetails.id }) {
            //                cart.cartItems[index].quantity += 1
            print(cart.cartItems)
            print(cart.cartItems[index])
        } else {
            print(cart.cartItems)
            //cart.cartItems.append(CartItem(product: product, quantity: 1))
            //print(cart.cartItems)
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
