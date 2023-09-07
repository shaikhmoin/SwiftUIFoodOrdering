//
//  RegisterView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct RegisterView: View {
    
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    @State var error = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: LoginViewModel
    @EnvironmentObject var sessionManager:SessionManager
    @State var shouldShowImagePicker = false
    @State var selectedImage: UIImage?
    
    var body: some View {
        
        //        NavigationView {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        VStack {
                            if let image = self.selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                                    .foregroundColor(Color(.label))
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 64)
                            .stroke(Color.black, lineWidth: 3)
                        )
                    }
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
                    Button(action: {
                        self.createNewAccount()
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
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $selectedImage)
                .ignoresSafeArea()
        }
    }
    
     private func uploadphotoToStorage() {
        
        guard selectedImage != nil else { //check selected image is nil or not
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else { //check current user with a valid UID
            return
        }
        
        let storageref = Storage.storage().reference() //create storage reference
        
        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.5) else { return } //convert image into data
        
        let fileref = storageref.child("images/\(UUID().uuidString).jpg")
        
        //upload photo to storage
        fileref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                print("Failed to push image to Storage: \(err)")
                return
            }
            
            fileref.downloadURL { url, err in
                if let err = err {
                    print("Failed to retrieve downloadURL: \(err)")
                    return
                }
                
                print("Successfully stored image with url: \(url?.absoluteString ?? "")")
                print(url?.absoluteString)
                UserDefaults.standard.set(url?.absoluteString, forKey: SessionManager.userDefaultsKey.hasUserPhoto)
                
                //https://firebasestorage.googleapis.com:443/v0/b/restaurantfoodapp-e8233.appspot.com/o/tUnjbtEyZ4PnfbE8GfGGd4V5BJn2?alt=media&token=7ff82e13-40c5-443a-8f72-ac16ed510dc5
                
                if let imageUrl = url?.absoluteString {
                    // Save user data to Firestore
                    saveuserDataToFirestore(imageUrl: imageUrl)
                }
            }
        }
    }
    
    private func saveuserDataToFirestore(imageUrl: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        
        let dataToSave: [String: Any] = [
            "id": uid,
            "name": "This is an uploaded image.",
            "email": "This is an uploaded image.",
            "imageURL": imageUrl
        ]
        
        db.collection("images").document(uid).setData(dataToSave) { error in
            if let error = error {
                print("Error saving image data to Firestore: \(error.localizedDescription)")
            } else {
                print("Image data saved successfully!")
            }
        }
    }
  
    private func createNewAccount(){
        
        if viewModel.email != ""{
            
            if viewModel.password == self.repass{
                
                print("Success")
                
                //Signup with firebase
                viewModel.signUpWithFirebase(completion: { result in
                    
                    switch result {
                    case .success(let message):
                        print("Task completed successfully: \(message)")
                        UserDefaults.standard.set(viewModel.email, forKey: SessionManager.userDefaultsKey.hasUserEmail)
                        self.uploadphotoToStorage() //upload photo to storage and firestore db
                        
                        sessionManager.signIn()

                    case .failure(let error):
                        print("Task failed with error: \(error)")
                        self.error = error.localizedDescription
                        self.alert.toggle()
                    }
                })
            }
            else{
                
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        }
        else{
            
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
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
