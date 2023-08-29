//
//  SettingsView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import SwiftUI

struct ProductView: View {
    var icon: String
    var quantity: String
    
    var body: some View {
        VStack {
            Text(icon)
            Text(quantity)
        }
        .padding()
    }
}

struct SettingsView: View {
    
    @State private var isDarkModeEnabled: Bool = true
    @State private var downloadViaWifiEnabled: Bool = false
    @State private var isShowingDonationView: Bool = false
    
    @State private var languageIndex = 0
    @EnvironmentObject private var session: SessionManager
    @StateObject var viewModel: LoginViewModel
    
    var languageOptions = ["English", "Arabic", "Chinese", "Danish"]
    @AppStorage("email") var emailID: String = ""
    @StateObject private var alertManager = GlobalAlertManager()
    @EnvironmentObject private var purchaseManager: StorekitManager
    @AppStorage(Persistence.consumablesCountKey) var consumableCount: Int = 0

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
                            Text(emailID)
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
                    
                    Button(action: {
                        viewModel.updateEmail(selectedEmail: "moinshk67@gmail.com") { result in
                            switch result {
                            case .success(let message):
                                print("Success: \(message)")
                                
                                session.signOut()//Normal logout
                                viewModel.signOut()//Firebase logout
                                alertManager.showAlert(title: "Alert", message: message)
                                
                            case .failure(let error):
                                print("Error: \(error)")
                                alertManager.showAlert(title: "Alert", message: "Something wrong during changing Email")
                            }
                        }
                        
                    }) {
                        HStack {
                            Image(uiImage: UIImage(named: "PlayInBackground")!)
                            Text("Update Email")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Button(action: {
                        viewModel.updatePassword(selectedPassword: "123456") { result in
                            switch result {
                            case .success(let message):
                                print("Success: \(message)")
                                
                                session.signOut()//Normal logout
                                viewModel.signOut()//Firebase logout
                                alertManager.showAlert(title: "Alert", message: message)
                                
                            case .failure(let error):
                                print("Error: \(error)")
                                alertManager.showAlert(title: "Alert", message: "Something wrong during changing Password")
                            }
                        }
                        
                    }) {
                        HStack {
                            Image(uiImage: UIImage(named: "PlayInBackground")!)
                            Text("Update Password")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Button(action: {
                        viewModel.resetPassword { result in
                            switch result {
                            case .success(let message):
                                print("Success: \(message)")
                                alertManager.showAlert(title: "Alert", message: message)
                                
                            case .failure(let error):
                                print("Error: \(error)")
                                alertManager.showAlert(title: "Alert", message: "Something wrong during changing Reset Password")
                            }
                        }
                        
                    }) {
                        HStack {
                            Image(uiImage: UIImage(named: "PlayInBackground")!)
                            Text("Reset Password")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Button(action: {
                        isShowingDonationView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(.black)
                            Text("Donation")
                                .foregroundColor(.black)
                        }
                    }
                    .sheet(isPresented: $isShowingDonationView) {
                        donationView
                        //                            .presentationDetents([.medium])
                            .presentationDetents([.fraction(0.30)])
                        
                            .presentationDragIndicator(.visible)
                    }
                    
                    Button(action: {
                        print("Logout clicked")
                        session.signOut()//Normal logout
                        viewModel.signOut()//Firebase logout
                        
                    }) {
                        HStack {
                            Image(uiImage: UIImage(named: "PlayInBackground")!)
                            Text("Log out")
                                .foregroundColor(.black)
                        }
                    }
                })
            }
            .alert(item: $alertManager.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Settings")
            .navigationBarHidden(true)
        }
    }
    
    var donationView: some View {
        VStack{
            Text("Select Donation Amount")
            
            ProductView(
                icon: "❤️",
                quantity: "\(consumableCount)"
            )
            
            HStack() {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        //Display inapp purchase
                        ForEach(purchaseManager.products) { product in
                            DonationButtonView(amount: product.displayPrice) {

                                print(product.id)
                                print(product.displayName)
                                print(product.displayPrice)
                                
                                //Click to purchase product
                                Task {
                                    do {
                                        print(product)
                                        try await purchaseManager.purchase(product)
                                    } catch {
                                        print(error)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            
            //            HStack() {
            //
            //                Button("") {
            //
            //                }
            //                .buttonStyle(DonationButtonImage(systemImageName: "airplane"))
            //
            //                Button("") {
            //
            //                }
            //                .buttonStyle(DonationButtonImage(systemImageName: "car.fill"))
            //
            //                Button("") {
            //
            //                }
            //                .buttonStyle(DonationButtonImage(systemImageName: "ferry.fill"))
            //
            //                Button("") {
            //
            //                }
            //                .buttonStyle(DonationButtonImage(systemImageName: "tram.fill"))
            //            }
            
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let loginViewModel = LoginViewModel() // Declare the variable
        SettingsView(viewModel: loginViewModel)
    }
}

struct DonationButtonView: View {
    var amount: String
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            Text(amount)
                .foregroundColor(.white)
                .fontWeight(.medium)
        }
        .foregroundColor(.white)
        //        .frame(width: 50, height: 15) // Adjust height as needed
        .padding()
        .background(Color.pink)
        .clipShape(Capsule())
        .fixedSize() // Button width adjusts based on content
    }
}

struct DonationButtonImage: ButtonStyle {
    let systemImageName: String
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: systemImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .frame(width: 33, height: 33)
            .padding()
            .background(.pink)
            .clipShape(Circle())
    }
}
