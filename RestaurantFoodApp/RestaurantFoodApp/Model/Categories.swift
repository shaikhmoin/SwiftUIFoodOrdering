//
//  Categories.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import Foundation

struct CategoryCard : Identifiable {
    var id : Int
    var image : String
    var name : String
}

var testCategoryData:[CategoryCard] = [
    CategoryCard(id: 0, image: "categ-1", name: "Pizza"),
    CategoryCard(id: 1, image: "categ-2", name: "Drinks"),
    CategoryCard(id: 2, image: "categ-3", name: "Tacos"),
    CategoryCard(id: 3, image: "categ-4", name: "Burger"),
    CategoryCard(id: 4, image: "categ-3", name: "Tacos"),
    CategoryCard(id: 5, image: "categ-4", name: "Burger"),
    CategoryCard(id: 6, image: "categ-5", name: "Fries"),
    CategoryCard(id: 7, image: "categ-6", name: "Top"),
]

var FoodTypes = ["Pizza","Drinks","Tacos","Burger","Fries","Top"]
