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
    
    //Create user
    func signUpWithFirebase(completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
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
    
    //SignIn user
    func signInWithFirebase(completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        Task {
            do {
                let returnUserData = try await AuthenticationManager.shared.SignInUser(email: email, password: password)
                print(returnUserData)
                
                completion(.success(returnUserData))
                
            } catch {
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    //Get Existing user
    func getExistingUser(completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
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
    
    func resetPassword(completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                let authUser = try AuthenticationManager.shared.getAuthenticateUser()
                print(authUser)
                
                guard let email = authUser.email else {
                    throw URLError(.fileDoesNotExist)
                }
                
                do {
                    let getReset = try await AuthenticationManager.shared.resetPassword(email: authUser.email ?? "")
                    print(getReset)
                    completion(.success("Reset link sent on your mail!"))

                } catch {
                    print("Error: \(error)")
                    completion(.failure(error))
                }
                
            } catch {
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func updateEmail(selectedEmail: String, completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                let result = try await AuthenticationManager.shared.updateEmail(email: selectedEmail)
                print(result)
                completion(.success("Email updated successfully"))
                
            } catch {
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func updatePassword(selectedPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                let result = try await AuthenticationManager.shared.updatePassword(password: selectedPassword)
                print(result)
                completion(.success("Password updated successfully"))
                
            } catch {
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    //Logout
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
