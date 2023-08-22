//
//  OnboardingView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 11/08/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var selectedPage = 0
    @State private var isPresenting : Bool = false
//    @Binding var loggedIn: Bool //For login-logout
    @EnvironmentObject var sessionManager:SessionManager
    let action: () -> Void
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical) {
                ZStack {
                    
                    Color.black
                        .ignoresSafeArea()
                    
                    Circle()
                        .frame(width: 500, height: 800)
                        .foregroundColor(.blue.opacity(0.6))
                        .offset(x: 0, y: -150)
                    
                    Circle()
                        .frame(width: 600, height: 600)
                        .foregroundColor(.white)
                        .offset(x: 0, y: -250)
                    
                    //Main title, description and Dots here
                    TabView(selection: $selectedPage)
                    {
                        ForEach(0..<testData.count){
                            index in CardView(card : testData[index]).tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    
                    //Right Arrow Button
                    Button(action : {
                        selectedPage += 1
                        
                        if selectedPage == 3 {
                            isPresenting = true
                            //loggedIn = true
                            action()
                            
                        }
                    })
                    {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 35)
                    }
                    
                    .offset(x: 0, y: 335)
                    
                    //OLD
//                    NavigationLink("", destination: LoginView().environmentObject(sessionManager)
//                                   , isActive: $isPresenting)
                    
                    //Lottie images
                    if (selectedPage == 0)
                    {
                        ZStack{
                            LottieView(filename: "order")
                                .frame(width: 500, height: 500)
                                .clipShape(Circle())
                                .shadow(color: .orange, radius: 1, x: 0, y: 0)
                                .offset(x: 0, y: -140)
                        }
                    }
                    
                    if (selectedPage == 1)
                    {
                        ZStack{
                            LottieView(filename: "interaction")
                                .frame(width: 500, height: 500)
                                .shadow(color: .orange, radius: 1, x: 0, y: 0)
                                .clipShape(Circle())
                                .offset(x: 10, y: -152)
                        }
                    }
                    
                    if (selectedPage == 2)
                    {
                        ZStack{
                            LottieView(filename: "delivery")
                                .frame(width: 500, height: 500)
                                .shadow(color: .orange, radius: 1, x: 0, y: 0)
                                .clipShape(Circle())
                                .offset(x: 0, y: -140)
                        }
                    }
                }
            }
            .background(.black)
        }
    }
}

//struct OnboardingView_Previews: PreviewProvider {
//    
//    // we show the simulated view, not the BoolButtonView itself
//    static var previews: some View {
//        OnboardingView()
////        OtherView()
////            .preferredColorScheme(.light)
//    }
//    
//    // nested OTHER VIEW providing the one value for binding makes the trick
////    private struct OtherView : View {
////
////        @State var providedValue : Bool = false
////
////        var body: some View {
////            OnboardingView(loggedIn: $providedValue)
////        }
////    }
//}
