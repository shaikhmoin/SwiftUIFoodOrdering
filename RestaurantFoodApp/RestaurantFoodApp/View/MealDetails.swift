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
    var placeHolder = "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit "
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var cartManager = CartManager()

    var body: some View {
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

                    Text(placeHolder)
                        .padding(.top, 10)
                        .fixedSize(horizontal: false, vertical: true)

                    HStack {
                        Text("Quantity ")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Stepper("",
                                onIncrement: {
                                    quantity+=1
                                }, onDecrement: {
                                    quantity-=1
                                })
                            .foregroundColor(.black)
                            .background(Color.white)
                            .frame(width: 100)
                    }.padding(.top, 10)

                    HStack {
                        Text("Price ")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("$\(quantity+1).00")
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
//                    cartManager.addToCartCard(item: mealDetails)
                    cartManager.addToCart(product: mealDetails)

                }, label: {
                    Text("Add to Cart")
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
    }
}

struct MealDetails_Previews: PreviewProvider {
    static var previews: some View {
//        MealDetails()
        MealDetails(mealDetails: testTrendingData[0])
    }
}
