//
//  CategoriesView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import SwiftUI

struct CategoriesView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(1 ..< 7) { i in
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
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.3)
                            .cornerRadius(15)
                            .shadow(radius: 1)
                    )
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 500)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
