//
//  LoginViewModel.swift
//  RestaurantFoodApp
//
//  Created by macOS on 17/08/23.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn(completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        Task {
            do {
                let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print(returnUserData)
                
                completion(.success(returnUserData))
                
            } catch {
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func getExistingUser(completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
        //        guard !email.isEmpty, !password.isEmpty else {
        //            print("No email or password found.")
        //            return
        //        }
        
        Task {
            do {
                let returnUserData = try AuthenticationManager.shared.getAuthenticateUser()
                print(returnUserData)
                
                completion(.success(returnUserData))
                
            } catch {
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                let returnUserData: () = try AuthenticationManager.shared.signOut()

                print(returnUserData)
                
               // completion(.success(returnUserData))
                
            } catch {
                print("Error: \(error)")
              //  completion(.failure(error))
            }
        }
    }
}
