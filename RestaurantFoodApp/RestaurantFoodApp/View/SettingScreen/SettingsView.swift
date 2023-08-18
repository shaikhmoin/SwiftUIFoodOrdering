//
//  SettingsView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isDarkModeEnabled: Bool = true
    @State private var downloadViaWifiEnabled: Bool = false
    @State private var languageIndex = 0
    
    var languageOptions = ["English", "Arabic", "Chinese", "Danish"]
    
    var body: some View {
        NavigationView {
            Form {
                Group {
                    HStack{
                        Spacer()
                        VStack {
                            Image(uiImage: UIImage(named: "UserProfile")!)
                                .resizable()
                                .frame(width:100, height: 100, alignment: .center)
                            Text("Wolf Knight")
                                .font(.title)
                            Text("WolfKnight@kingdom.tv")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {
                                print("Edit Profile tapped")
                            }) {
                                Text("Edit Profile")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                            .background(Color.blue)
                            .cornerRadius(25)
                        }
                        Spacer()
                    }
                }
                
                Section(header: Text("Food Orders"), content: {
                    HStack{
                        Image(uiImage: UIImage(named: "Favorite")!)
                        Text("Favorite orders")
                    }
                    
                    HStack{
                        Image(systemName: "purchased.circle")
                        Text("Your orders")
                    }
                    
                    HStack{
                        Image(systemName: "bag.badge.plus")
                        Text("Address")
                    }
                })
                
                Section(header: Text("PREFRENCES"), content: {
                    HStack{
                        Image(uiImage: UIImage(named: "Language")!)
                        Picker(selection: $languageIndex, label: Text("Language")) {
                            ForEach(0 ..< languageOptions.count) {
                                Text(self.languageOptions[$0])
                            }
                        }
                    }
                    HStack{
                        Image(uiImage: UIImage(named: "DarkMode")!)
                        Toggle(isOn: $isDarkModeEnabled) {
                            Text("Dark Mode")
                        }
                    }
                    HStack{
                        Image(systemName: "hand.raised.fingers.spread")
                        Text("About us")
                    }
                    HStack{
                        Image(uiImage: UIImage(named: "PlayInBackground")!)
                        Text("Log out")
                    }
                    
                })
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
