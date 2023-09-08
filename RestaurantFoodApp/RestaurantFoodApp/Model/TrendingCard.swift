//
//  TrendingCard.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import Foundation

struct TrendingCard : Codable, Identifiable {
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
    TrendingCard(image: "maxresdefault1", title: "Crispy Fried Burger", descrip: "AsianBBQ", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 5, price: 10.0, expand: false, Qty: 1, productID: "com.nonconsumablelifetime.product"),
    TrendingCard(image: "maxresdefault2", title: "Checken Pizza combo", descrip: "Spicy combination", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 3, price: 12.0, expand: false, Qty: 1, productID: "com.consumableonetime.product"),
    TrendingCard(image: "maxresdefault3", title: "Chinese Salad", descrip: "Best Seller", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 4, price: 18.0, expand: false, Qty: 1, productID: "com.autorenewable.product"),
    TrendingCard(image: "maxresdefault4", title: "Punjabi bigger thali", descrip: "Punkab di shaan", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 5, price: 30.0, expand: false, Qty: 1, productID: "com.nonautorenewable.product"),
]
