//
//  CurrentLocationView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI

struct CurrentLocationView: View {
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    LottieView(filename: "currentlocation")
                        .frame(width: 400, height: 400)
                    //                    .offset(x: 0, y: -152)
                    
                    Text("Hi, nice to meet you !")
                        .font(.title)
                        .bold()
                    Text("Choose your location to find \nrestraurants around you. ")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .padding(.all, 20)
                    
                    NavigationLink(
                        destination: TabbarView().navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        label: {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                
                                Text("Use current location")
                                    .bold()
                                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                
                            }
                            .frame(width: 300, height: 60, alignment: .center)
                            .border(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), width: 3)
                            .cornerRadius(5)
                        })
                    
                    Text("Select Manually")
                        .bold()
                        .underline()
                        .foregroundColor(.gray)
                        .padding(.top, 80)
                    Spacer()
                    
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct CurrentLocationView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocationView()
    }
}
