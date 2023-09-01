//
//  CategoryView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 01/09/23.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    SearchBar()
                    
                    VStack {
                        
                      
                    }
                    .padding(.top, -20)
                }
            }
            .background(.white)
            .ignoresSafeArea()
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
