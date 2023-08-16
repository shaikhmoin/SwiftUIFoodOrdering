//
//  OurPicks.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import Foundation

struct OurPicksCard : Identifiable {
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

    var isAdded : Bool = false
}

var testOurPicksData:[OurPicksCard] = [
    OurPicksCard(image: "maxresdefault1", title: "Crispy Fried Sandwich", descrip: "KoreanBBQ", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 5, price: 25.0, expand: false, Qty: 1),
    OurPicksCard(image: "maxresdefault2", title: "Shrimp Fries", descrip: "Hot Sauce", longDescrip: "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit",stars: 3, price: 14.0, expand: false, Qty: 1),
]
