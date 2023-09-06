//
//  RegisterView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    @State var error = ""
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: LoginViewModel
    @EnvironmentObject var sessionManager:SessionManager

    var body: some View {
        
        VStack(alignment: .leading){
            
            GeometryReader{_ in
                
                VStack{
                    LottieView(filename: "order")
                        .frame(width: 300, height: 250)
                        .shadow(color: .orange, radius: 1, x: 0, y: 0)
                        .clipShape(Circle())
                        .padding()
                    
                    Text("Sign up a new account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
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
                    
                    
                    // Confirm password
                    HStack(spacing: 15){
                        VStack{
                            if self.revisible {
                                TextField("Confirm Password", text: self.$repass)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Confirm Password", text: self.$repass)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            self.revisible.toggle()
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
                    
                    
                    // Sign up button
                   // NavigationLink(destination: CurrentLocationView(), tag: 1, selection: $selection) {
                        Button(action: {
                            self.Register()
                        }) {
                            Text("Sign up")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("themecolor"))
                        .cornerRadius(6)
                        .padding(.top, 15)
                        .alert(isPresented: self.$alert){()->Alert in
                            return Alert(title: Text("Sign up error"), message: Text("\(self.error)"), dismissButton:
                                    .default(Text("OK").fontWeight(.semibold)))
                        }
                  //  }
                    
                    HStack(spacing: 5){
                        Text("Already have an account ?")
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()

                        } label: {
                            Text("Sign In")
                                .fontWeight(.bold)
                                .foregroundColor(Color("themecolor"))
                        }
                        
                        Text("now").multilineTextAlignment(.leading)
                        
                    }.padding(.top, 25)
                }
                .padding(.horizontal, 25)
                .navigationBarHidden(true)
            }
        }
    }
    
    func Register(){
        
        if viewModel.email != ""{
            
            if viewModel.password == self.repass{
                
                print("Success")
                selection = 1
                
                //Signup with firebase
                viewModel.signUpWithFirebase(completion: { result in
                    
                    switch result {
                    case .success(let message):
                        print("Task completed successfully: \(message)")
                        UserDefaults.standard.set(viewModel.email, forKey: SessionManager.userDefaultsKey.hasUserEmail)
                        sessionManager.signIn()
                        
                    case .failure(let error):
                        print("Task failed with error: \(error)")
                        self.error = error.localizedDescription
                        self.alert.toggle()
                        selection = 0
                    }
                })
            }
            else{
                
                self.error = "Password mismatch"
                self.alert.toggle()
                selection = 0
            }
        }
        else{
            
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
            selection = 0
        }
        
        //        if self.email != ""{
        //
        //            if self.pass == self.repass{
        //
        //                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
        //
        //                    if err != nil{
        //
        //                        self.error = err!.localizedDescription
        //                        self.alert.toggle()
        //                        return
        //                    }
        //
        //                    print("success")
        //
        //                    UserDefaults.standard.set(true, forKey: "status")
        //                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
        //                }
        //            }
        //            else{
        //
        //                self.error = "Password mismatch"
        //                self.alert.toggle()
        //            }
        //        }
        //        else{
        //
        //            self.error = "Please fill all the contents properly"
        //            self.alert.toggle()
        //        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: LoginViewModel())
    }
}
