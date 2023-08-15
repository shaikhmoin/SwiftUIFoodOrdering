//
//  OurPicks.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import Foundation

struct OurPicksCard : Identifiable {
    var id : Int
    var image : String
    var title : String
    var descrip : String
    var stars : Int
    var price = "$25.00"
    var expand : Bool
}

var testOurPicksData:[OurPicksCard] = [
    OurPicksCard(id: 0, image: "maxresdefault1", title: "Crispy Chicken Sandwich", descrip: "KoreanBBQ",stars: 5, expand: false),
    OurPicksCard(id: 1, image: "maxresdefault2", title: "Shrimp Fries", descrip: "Hot Sauce",stars: 3, expand: false),
]
