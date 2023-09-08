//
//  CategoryView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 01/09/23.
//

import SwiftUI

struct CategoryView: View {
    
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var categoryIndex = 0
    @State var text = ""
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    SearchBar()
                    
                    //segment view
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30){
                            ForEach(0..<categories.count, id: \.self){data in
                                
                                Categories(data: data, index: $categoryIndex)
                            }
                        }
                    }
                    .padding()
                    .padding(.top, -20)
                    
                    
                    //main items view
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVGrid(columns: columns, spacing: 20){
                            ForEach(fData.filter({ "\($0)".contains(text) || text.isEmpty})){ food in
                                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
                                    VStack {
                                        Image("\(food.image)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 150)
                                        
                                        HStack {
                                            VStack (alignment: .leading){
                                                Text(food.title)
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                
                                                Text(food.amount)
                                                    .foregroundColor(.black)
                                                
                                                Text(food.price)
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                    .fontWeight(.semibold)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: 45, height: 45)
                                        .overlay(
                                            Image(systemName: "cart")
                                                .resizable()
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .foregroundColor(Color("themecolor"))
                                        )
                                        .shadow(color: Color("themecolor").opacity(0.05), radius: 8, x:0 , y: 5)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 20)
                                .background(Color(food.cardColor))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(color: Color(food.cardColor).opacity(0.5), radius: 10, x:0, y: 10)
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 100)

                    Spacer()
                }
            }
            .background(.white)
            .ignoresSafeArea()
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
        }
    }
}

struct Categories: View {
    
    var data: Int
    @Binding var index: Int
    
    var body: some View{
        VStack(spacing: 8 ){
            Text(categories[data])
                .foregroundColor(.black)
                .font(.system(size: 22))
                .fontWeight(index == data ? .bold : .none)
                .foregroundColor(Color(index == data ? "mainfont" : "subfont"))
            
            Capsule()
                .fill(Color("themecolor"))
                .frame(width: 30, height: 4)
                .opacity(index == data ? 1 : 0)
        }.onTapGesture {
            withAnimation {
                index = data
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}


struct Food: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var amount: String
    var cardColor: String
    var price: String
}

var categories = ["Pizza", "Drinks", "Tacos", "Fries", "Top", "Burger"]

var fData = [
    Food(title: "Peaches", image: "1", amount: "1 lb", cardColor: "GrayColor", price: "$2.99"),
    Food(title: "Plant", image: "2", amount: "1 pc", cardColor: "themecolor", price: "$0.99"),
    Food(title: "Apple", image: "3", amount: "1 lb", cardColor: "themecolor", price: "$3.99"),
    Food(title: "Peaches", image: "4", amount: "1 lb", cardColor: "GrayColor", price: "$2.99"),
    Food(title: "Peaches", image: "1", amount: "1 lb", cardColor: "GrayColor", price: "$2.99"),
    Food(title: "Plant", image: "2", amount: "1 pc", cardColor: "themecolor", price: "$0.99"),
    Food(title: "Apple", image: "3", amount: "1 lb", cardColor: "themecolor", price: "$3.99"),
    Food(title: "Peaches", image: "4", amount: "1 lb", cardColor: "GrayColor", price: "$2.99"),
]

class Colors {

   static let color1 = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
   static let color2 = UIColor(displayP3Red: 2, green: 2, blue: 2, alpha: 1)
   static let color3 = UIColor(displayP3Red: 3, green: 3, blue: 3, alpha: 1)
}
