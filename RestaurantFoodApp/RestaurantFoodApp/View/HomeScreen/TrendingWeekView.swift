//
//  TrendingWeekView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import SwiftUI

struct TrendingWeekView: View {
    
    @State var trendingMeal : TrendingCard
    
    var body: some View {
        VStack {
            Image(trendingMeal.image)
                .resizable()
                .frame(width: 250, height: 150)
            
            HStack {
                Text(trendingMeal.title)
                    .bold()
                    .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
            HStack {
                Text(trendingMeal.descrip)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
            HStack {
                ForEach(0 ..< trendingMeal.stars) { item in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
                Spacer()
                
                Text("$\(forTrailingZero(trendingMeal.price))")
                    .font(.subheadline)
                    .bold()
            }
            .padding(.bottom, 30)
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
        }
        
        .frame(width: 250, height: 250)
        .cornerRadius(10)
    }
    
    func forTrailingZero(_ temp: Double) -> String {
        var tempVar = String(format: "%g", temp)
        return tempVar
    }
}

struct TrendingWeekView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingWeekView(trendingMeal: testTrendingData[0])
    }
}
