//
//  LoginView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct LoginView: View {
    
    @State var email = ""
    @State var pass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    @State var name = ""
    
    @State private var isSHowHomeView: Bool = false
    
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var emailID: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    @AppStorage("log_Status") var log_status = false
    
    @EnvironmentObject var sessionManager:SessionManager
    @StateObject var viewModel: LoginViewModel
    
    private var isSignedIn: Bool {
        !userID.isEmpty
    }
    
    var body: some View {
        
        VStack{
            LottieView(filename: "order")
                .frame(width: 300, height: 250)
                .shadow(color: .orange, radius: 1, x: 0, y: 0)
                .clipShape(Circle())
                .padding()
            
            Text("Sign in to your account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            TextField("Username or Email",text:self.$viewModel.email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
                .padding(.top, 0)
            
            HStack(spacing: 15){
                VStack{
                    if self.visible {
                        TextField("Password", text: self.$viewModel.password)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Password", text: self.$viewModel.password)
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
            
            HStack(spacing: 5){
                Text("Don't have an account ?")
                
                NavigationLink(destination: RegisterView()){
                    Text("Sign up")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bg"))
                }
                
                Text("now").multilineTextAlignment(.leading)
                
            }.padding(.top, 25)
            
            //Apple signIn button
//            if !isSignedIn {
                SignInButtonView { success in
                    if success {
                        isSHowHomeView = true
                        sessionManager.signIn()
                    } else {
                        isSHowHomeView = false
                    }
                }
//            } else {
//
//            }
            NavigationLink("", destination: HomeView(viewModel: viewModel), isActive: $isSHowHomeView)
        }
        .padding(.horizontal, 25)
        .navigationBarHidden(true)
    }
    
    private func showAppleLoginView() {
        print("ShowAppleLoginView")
    }
    
    func Verify(){
        if viewModel.email != "" && viewModel.password != "" {
            print("Success")
            
            //Signin with firebase
            viewModel.signInWithFirebase(completion: { result in
                
                switch result {
                case .success(let message):
                    print("Task completed successfully: \(message)")
                    
                    emailID = message.email ?? ""
                    print(emailID)
//                    var userDefaults = UserDefaults.standard
                    
//                    do{
//                        let loginData = try NSKeyedArchiver.archivedData(withRootObject: message, requiringSecureCoding: true)
//                        UserDefaults.standard.set(loginData, forKey: "LoginData")
//                        UserDefaults.standard.synchronize()
//                    }catch (let error){
//                        #if DEBUG
//                            print("Failed to convert UIColor to Data : \(error.localizedDescription)")
//                        #endif
//                    }
//
//                    do{
//                        if let loginData = UserDefaults.standard.object(forKey: "LoginData") as? Data{
//                            if let userData = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [UIColor.self], from: loginData){
//                                print(userData)
//                            }
//                        }
//                    }catch (let error){
//                        #if DEBUG
//                            print("Failed to convert UIColor to Data : \(error.localizedDescription)")
//                        #endif
//                    }
                                     
                    sessionManager.signIn()
                    
                case .failure(let error):
                    print("Task failed with error: \(error)")
//                    self.title = "Login Error"
//                    self.error = error.localizedDescription
//                    self.alert = true
                    
                    //Signup with firebase
                    viewModel.signUpWithFirebase(completion: { result in
                        
                        switch result {
                        case .success(let message):
                            print("Task completed successfully: \(message)")
                            sessionManager.signIn()
                            
                        case .failure(let error):
                            print("Task failed with error: \(error)")
                            self.title = "Login Error"
                            self.error = error.localizedDescription
                            self.alert = true
                        }
                    })
                }
            })
            
        } else {
            self.title = "Login Error"
            self.error = "Please fill all the content properly"
            self.alert = true
        }
    }
}

struct SignInButtonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("email") var emailID: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    @AppStorage("log_Status") var log_status = false
    
    let onCompletion: (Bool) -> Void
    
    var body: some View {
        SignInWithAppleButton(.continue) { request in
            request.requestedScopes = [.fullName, .email]
            
        } onCompletion: { result in
            
            switch result {
            case .success(let authResults):
                print("Authorisation successful")
                print(authResults.credential)
                
                switch authResults.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    
                    //User ID
                    let userIdentifier = appleIDCredential.user
                    print(userIdentifier)
                    
                    //User Info
                    let userEmail = appleIDCredential.email
                    let identityToken = appleIDCredential.identityToken
                    let firstName = appleIDCredential.fullName?.givenName
                    let lastName = appleIDCredential.fullName?.familyName
                    
                    print(userEmail)
                    print(identityToken)
                    print(firstName)
                    print(lastName)
                    
                    self.emailID = userEmail ?? ""
                    self.userID = userIdentifier
                    self.firstName = firstName ?? ""
                    self.lastName = lastName ?? ""
                    
                    onCompletion(true)
                    
                default:
                    break
                }
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
        
        let loginViewModel = LoginViewModel() // Declare the variable
        LoginView(viewModel: loginViewModel)
    }
}
