//
//  CategoriesView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import SwiftUI

struct CategoriesView: View {
    
    @State var categoriesDT : CategoryCard
    
    var body: some View {
        VStack {
            Image(categoriesDT.image)
                .resizable()
                .frame(width: 80, height: 60)
            
            Text(categoriesDT.name)
                .bold()
                .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        
        .frame(width: 80, height: 100)
        .cornerRadius(10)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categoriesDT: testCategoryData[0])
    }
}
