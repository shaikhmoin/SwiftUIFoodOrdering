//
//  LoginView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @State var email = ""
    @State var pass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    @State var selection: Int? = nil
    @State var name = ""
    
    @State private var isSignedIn = false
    @State private var provideValue: Int? = nil
    
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var emailID: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    
    @AppStorage("log_Status") var log_status = false

//    private var isSignedIn: Bool {
//        !userID.isEmpty
//    }
    
    var body: some View {
        
        NavigationView {
            VStack(){
                //            Image("finance_app").resizable().frame(width: 300.0, height: 255.0, alignment: .top)
                
                LottieView(filename: "order")
                    .frame(width: 300, height: 250)
                    .shadow(color: .orange, radius: 1, x: 0, y: 0)
                    .clipShape(Circle())
                    .padding()
                
                Text("Sign in to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                
                TextField("Username or Email",text:self.$email)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
                    .padding(.top, 0)
                
                HStack(spacing: 15){
                    VStack{
                        if self.visible {
                            TextField("Password", text: self.$pass)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Password", text: self.$pass)
                                .autocapitalization(.none)
                        }
                    }
                    
                    Button(action: {
                        self.visible.toggle()
                    }) {
                        //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(self.color)
                            .opacity(0.8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(borderColor,lineWidth: 2))
                .padding(.top, 10)
                
                HStack{
                    Spacer()
                    Button(action: {
                        print("Reset password click")
                        // self.ResetPassword()
                        self.visible.toggle()
                    }) {
                        Text("Forget Password")
                            .fontWeight(.medium)
                            .foregroundColor(Color("bg"))
                    }.padding(.top, 10.0)
                }
                
                // Sign in button
                NavigationLink(destination: CurrentLocationView(), tag: 1, selection: $selection) {
                    Button(action: {
                        self.Verify()
                        
                    }) {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("bg"))
                    .cornerRadius(6)
                    .padding(.top, 15)
                    .alert(isPresented: $alert){()->Alert in
                        return Alert(title: Text("\(self.title)"), message: Text("\(self.error)"), dismissButton:
                                .default(Text("OK").fontWeight(.semibold)))
                    }
                }
                
                
                
                HStack(spacing: 5){
                    Text("Don't have an account ?")
                    
                    NavigationLink(destination: RegisterView()){
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(Color("bg"))
                    }
                    
                    Text("now").multilineTextAlignment(.leading)
                    
                }.padding(.top, 25)

                if !isSignedIn {
                    SignInButtonView { success in
                        isSignedIn = success
                        if success {
                            provideValue = 1 // Activate NavigationLink
                        }
                    }
                } else {
                    NavigationLink(destination: HomeView(), tag: 1, selection: $provideValue) {
                        EmptyView()
                    }
                }
            }
            
            .padding(.horizontal, 25)
            .navigationBarHidden(true)
        }
    }
    
    private func showAppleLoginView() {
        print("ShowAppleLoginView")
    }
    
    func Verify(){
        if self.email != "" && self.pass != "" {
            print("Success")
            self.selection = 1
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
        } else {
            self.title = "Login Error"
            self.error = "Please fill all the content property"
            self.alert = true
            self.selection = 0
        }
        //        if self.email != "" && self.pass != ""{
        //            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
        //
        //                if err != nil{
        //
        //                    self.error = err!.localizedDescription
        //                    self.title = "Login Error"
        //                    self.alert.toggle()
        //                    return
        //                }
        //
        //                print("Login success!")
        //                UserDefaults.standard.set(true, forKey: "status")
        //                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
        //            }
        //        }else{
        //            self.title = "Login Error"
        //            self.error = "Please fill all the content property"
        //            self.alert = true
        //        }
    }
}

struct SignInButtonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var emailID: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    
    @AppStorage("log_Status") var log_status = false

//    @State var provideValue: Int = 0
    
    let onCompletion: (Bool) -> Void

    var body: some View {
        SignInWithAppleButton(.continue) { request in
            request.requestedScopes = [.fullName, .email]
            
        } onCompletion: { result in
            
            switch result {
            case .success(let authResults):
                print("Authorisation successful")
                print(authResults.credential)
                
                onCompletion(true)

//                switch authResults.credential {
//                case let appleIDCredential as ASAuthorizationAppleIDCredential:
//
//                    //User ID
//                    let userIdentifier = appleIDCredential.user
//                    print(userIdentifier)
//
//                    //User Info
//                    let userEmail = appleIDCredential.email
//                    let identityToken = appleIDCredential.identityToken
//                    let firstName = appleIDCredential.fullName?.givenName
//                    let lastName = appleIDCredential.fullName?.familyName
//
//                    print(userEmail)
//                    print(identityToken)
//                    print(firstName)
//                    print(lastName)
//
//                    self.emailID = userEmail ?? ""
//                    self.userID = userIdentifier
//                    self.firstName = firstName ?? ""
//                    self.lastName = lastName ?? ""
//
////                    self.provideValue = true
//
//                    provideValue = 1 //Redirecting to home screen
//
//                default:
//                    break
//                }
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
                onCompletion(false)
            }
        }
        
        // black button
        .signInWithAppleButtonStyle(.black)
        // white button
        .signInWithAppleButtonStyle(.white)
        // white with border
        .signInWithAppleButtonStyle(
            colorScheme == .dark ? .white : .black
        )
        .frame(width: 200, height: 50)
        .cornerRadius(8)
        .padding(.top, 5)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
