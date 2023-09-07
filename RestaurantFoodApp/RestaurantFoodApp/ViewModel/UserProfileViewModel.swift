//
//  UserProfileViewModel.swift
//  RestaurantFoodApp
//
//  Created by iMac on 07/09/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct UserData: Identifiable {
    let id: String
    let name: String
    let email: String
    let imageURL: String
}

class UserProfileViewModel: ObservableObject {
    @Published var userImage: UIImage?
    @Published private var aryUserData: [UserData] = []

    func fetchUserData(completion: @escaping (Result<[UserData], Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("images").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    if let id = data["id"] as? String,
                       let name = data["name"] as? String,
                       let email = data["email"] as? String,
                       let imageURL = data["imageURL"] as? String{
                        
                        self.aryUserData = []
                        self.aryUserData.append(UserData(id: id, name: name, email: email, imageURL: imageURL))
                        print(self.aryUserData)
                        completion(.success(self.aryUserData))
                    }
                }
            } else {
                print("Image document not found: \(error?.localizedDescription ?? "")")
              //  completion(.failure(error?.localizedDescription))
            }
        }
    }
}
