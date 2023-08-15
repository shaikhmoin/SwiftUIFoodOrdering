//
//  TrendingCard.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import Foundation

struct TrendingCard : Identifiable {
    let id = UUID()
    var image : String
    var title : String
    var descrip : String
    var stars : Int
//    var price = "$25.00"
    var price : Double
    var expand : Bool
    var isAdded : Bool = false
}

var testTrendingData:[TrendingCard] = [
    TrendingCard(image: "maxresdefault1", title: "Crispy Fried Sandwich", descrip: "KoreanBBQ",stars: 5, price: 25.0, expand: false),
    TrendingCard(image: "maxresdefault2", title: "Shrimp Fries", descrip: "Hot Sauce",stars: 3, price: 14.0, expand: false),
    TrendingCard(image: "maxresdefault3", title: "Chinese Salad", descrip: "Best Seller",stars: 4, price: 22.0, expand: false),
    TrendingCard(image: "maxresdefault1", title: "Crispy Chicken Sandwich", descrip: "KoreanBBQ",stars: 5, price: 15.0, expand: false),
    TrendingCard(image: "maxresdefault2", title: "Shrimp Fries", descrip: "Hot Sauce",stars: 3, price: 11.0, expand: false),
    TrendingCard(image: "maxresdefault3", title: "Pizza pineapple", descrip: "dont buy iy",stars: 1, price: 24.0, expand: false),
]
