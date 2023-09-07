//
//  LoginView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import Firebase
import FirebaseStorage

struct LoginView: View {
    
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    @State var name = ""
    
    @State private var isSHowHomeView: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sessionManager:SessionManager
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
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
                        .background(RoundedRectangle(cornerRadius:6).stroke(Color("themecolor"),lineWidth:1))
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
                                .foregroundColor(Color("themecolor"))
                                .opacity(0.8)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("themecolor"),lineWidth: 1))
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
                                .foregroundColor(Color("themecolor"))
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
                    .background(Color("themecolor"))
                    .cornerRadius(6)
                    .padding(.top, 15)
                    .alert(isPresented: $alert){()->Alert in
                        return Alert(title: Text("\(self.title)"), message: Text("\(self.error)"), dismissButton:
                                .default(Text("OK").fontWeight(.semibold)))
                    }
                    
                    HStack(spacing: 5){
                        Text("Don't have an account ?")
                        
                        NavigationLink(destination: RegisterView(viewModel: LoginViewModel()).environmentObject(sessionManager)){
                            Text("Sign up")
                                .fontWeight(.bold)
                                .foregroundColor(Color("themecolor"))
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
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
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
                    
                    UserDefaults.standard.set(viewModel.email, forKey: SessionManager.userDefaultsKey.hasUserEmail)

                    
                    // Check if the user is logged in
//                    if let user = Auth.auth().currentUser {
//                        // Get the user's UID
//                        let uid = user.uid
//
//                        // Reference to the Firestore database
//                        let db = Firestore.firestore()
//
//                        // Reference to the user's document in Firestore (assuming a "users" collection)
//                        let userRef = db.collection("users").document(uid)
//
//                        // Fetch the user's document
//                        userRef.getDocument { document, error in
//                            if let document = document, document.exists {
//                                // Retrieve the image URL from the document
//                                if let imageUrlString = document.data()?["imageUrl"] as? String {
//                                    if let imageUrl = URL(string: imageUrlString) {
//                                        // Perform a network request to fetch the image asynchronously
//                                        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
//                                            if let data = data, let uiImage = UIImage(data: data) {
//                                                // Convert UIImage to SwiftUI Image
//                                                let swiftUIImage = Image(uiImage: uiImage)
//
//                                                // Update the userImage when the image data is fetched
//                                                DispatchQueue.main.async {
//                                                    userImage = swiftUIImage
//                                                }
//                                            } else {
//                                                // Handle errors if necessary
//                                                print("Failed to fetch or display image: \(error?.localizedDescription ?? "")")
//                                            }
//                                        }.resume()
//                                    }
//                                }
//                            } else {
//                                // Handle errors if necessary
//                                print("User document not found: \(error?.localizedDescription ?? "")")
//                            }
//                        }
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
                            UserDefaults.standard.set(viewModel.email, forKey: SessionManager.userDefaultsKey.hasUserEmail)
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
                    
                    UserDefaults.standard.set(userEmail, forKey: SessionManager.userDefaultsKey.hasUserEmail)
                    
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
