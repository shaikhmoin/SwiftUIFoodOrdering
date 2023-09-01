//
//  DropDown.swift
//  RestaurantFoodApp
//
//  Created by macOS on 31/08/23.
//

import SwiftUI

struct DropDown: View {
    @State var expand = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text("Select Area")
                        .foregroundColor(.black)
                    
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                }.onTapGesture {
                    withAnimation(.spring()){
                        self.expand.toggle()
                    }
                }
                
                if expand {
                    Button(action: {
                        self.expand.toggle()
                    }){
                        VStack(alignment: .leading, spacing: 15) {
                            Text("ABC Building Street 2")
                                .foregroundColor(.black)
                            
                            Divider()
                            
                            Text("ABC Building Street 2")
                                .foregroundColor(.black)
                            
                            Divider()
                            
                            Text("ABC Building Street 2")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.06), radius: 15, x: 0, y: 20)
                }
            }
        }
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}
