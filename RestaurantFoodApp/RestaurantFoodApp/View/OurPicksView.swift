//
//  OurPicksView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 14/08/23.
//

import SwiftUI

struct OurPicksView: View {
    
    @State var ourPickesDT : OurPicksCard
    
    var body: some View {
        
        VStack {
            ZStack {
                Image(ourPickesDT.image)
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width)*0.9 , height: (UIScreen.main.bounds.height)*0.25 )
                    .cornerRadius(20)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
            }.edgesIgnoringSafeArea(.top)
            
            HStack {
                Text(ourPickesDT.title)
                    .bold()
                    .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .padding(.leading,20)
            
            HStack {
                Text(ourPickesDT.descrip)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 30)
                Spacer()
            }
            
            HStack {
                ForEach(0 ..< ourPickesDT.stars) { item in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
                Spacer()
                
                Text(ourPickesDT.price)
                    .font(.subheadline)
                    .bold()
            }
            .padding(.bottom, 30)
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.leading, 20)
            .padding(.trailing,20)
        }
    }
}

struct OurPicksView_Previews: PreviewProvider {
    static var previews: some View {
        OurPicksView(ourPickesDT: testOurPicksData[0])
    }
}
