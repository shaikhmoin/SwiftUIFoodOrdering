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

enum UserProfileError: Error {
    case generic(String) // You can customize the error cases as needed
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
        
        db.collection("users").document(uid).getDocument { (document, error) in
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
    
    func updateProfileImage(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            completion(.failure(UserProfileError.generic("User is not authenticated.")))
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/\(uid).jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    imageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                            completion(.failure(error))
                        } else if let imageUrl = url?.absoluteString {
                            // Update the image URL in Firestore
                            let db = Firestore.firestore()
                            db.collection("users").document(uid).updateData([
                                "imageURL": imageUrl
                            ]) { error in
                                if let error = error {
                                    print("Error updating image URL in Firestore: \(error.localizedDescription)")
                                    completion(.failure(error))
                                } else {
                                    print("Image URL updated successfully!")
                                    completion(.success(()))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
