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
    var longDescrip : String
    var stars : Int
    //    var price = "$25.00"
    var price : Double
    var expand : Bool
    var Qty : Int = 1
    var productID : String
    var isAdded : Bool = false
}

private let productIds = ["com.nonconsumablelifetime.product", "com.consumableonetime.product" , "com.autorenewable.product", "com.nonautorenewable.product"]


var testTrendingData:[TrendingCard] = [
    TrendingCard(image: "maxresdefault1", title: "Crispy Fried Sandwich", descrip: "KoreanBBQ", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 5, price: 25.0, expand: false, Qty: 1, productID: "com.nonconsumablelifetime.product"),
    TrendingCard(image: "maxresdefault2", title: "Shrimp Fries", descrip: "Hot Sauce", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 3, price: 14.0, expand: false, Qty: 1, productID: "com.consumableonetime.product"),
    TrendingCard(image: "maxresdefault3", title: "Chinese Salad", descrip: "Best Seller", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 4, price: 22.0, expand: false, Qty: 1, productID: "com.autorenewable.product"),
    TrendingCard(image: "maxresdefault1", title: "Crispy Chicken Sandwich", descrip: "KoreanBBQ", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 5, price: 15.0, expand: false, Qty: 1, productID: "com.nonautorenewable.product"),
    TrendingCard(image: "maxresdefault2", title: "Shrimp Fries", descrip: "Hot Sauce", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 3, price: 11.0, expand: false, Qty: 1, productID: "com.test.product"),
    TrendingCard(image: "maxresdefault3", title: "Pizza pineapple", descrip: "dont buy iy", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 1, price: 24.0, expand: false, Qty: 1, productID: "com.test1.product"),
]
