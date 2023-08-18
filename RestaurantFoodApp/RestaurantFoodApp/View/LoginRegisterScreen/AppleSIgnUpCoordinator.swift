//
//  Coordinator.swift
//  AppleSignUp
//
//  Created by ds-mayur on 12/8/19.
//  Copyright © 2019 Mayur Rathod. All rights reserved.
//

import SwiftUI
import AuthenticationServices

class AppleSignUpCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    var parent: SignUpWithAppleView?
//    @State var providedValue : Bool = true

    init(_ parent: SignUpWithAppleView) {
        self.parent = parent
        super.init()

    }
    
    @objc func didTapButton() {
        //Create an object of the ASAuthorizationAppleIDProvider
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        //Create a request
        let request         = appleIDProvider.createRequest()
        //Define the scope of the request
        request.requestedScopes = [.fullName, .email]
        //Make the request
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        //Assingnig the delegates
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let vc = UIApplication.shared.windows.last?.rootViewController
        return (vc?.view.window!)!
    }
    
    //If authorization is successfull then this method will get triggered
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization)
    {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("credentials not found....")
            return
        }
        
        
        switch authorization.credential {
           case let appleIDCredential as ASAuthorizationAppleIDCredential:
               
            print(appleIDCredential)
               // Create an account in your system.
               let userIdentifier = appleIDCredential.user
               let fullName = appleIDCredential.fullName
               let email = appleIDCredential.email
            
            
            print(userIdentifier)
            print(fullName)
            print(email)
            
          //  HomeView(loggedIn: $providedValue)

               // For the purpose of this demo app, store the `userIdentifier` in the keychain.
//               self.saveUserInKeychain(userIdentifier)
//
//               // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
//               self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
           
         //  case let passwordCredential as ASPasswordCredential:
           
               // Sign in using an existing iCloud Keychain credential.
//               let username = passwordCredential.user
//               let password = passwordCredential.password
//
//               // For the purpose of this demo app, show the password credential as an alert.
//               DispatchQueue.main.async {
//                  // self.showPasswordCredentialAlert(username: username, password: password)
//               }
               
           default:
               break
           }
        
        //Storing the credential in user default for demo purpose only deally we should have store the credential in Keychain
//        let defaults = UserDefaults.standard
//        defaults.set(credentials.user, forKey: "userId")
//        parent?.name = "\(credentials.fullName?.givenName ?? "")"
        
//        print(credentials)
//        print(credentials.email)
//        print(credentials.fullName)
//        print(credentials.identityToken)
//        print(credentials.user)
        
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            // create an account in your system.
//            let userIdentifier = appleIDCredential.user
//            let userFirstName = appleIDCredential.fullName?.givenName
//            let userLastName = appleIDCredential.fullName?.familyName
//            let userEmail = appleIDCredential.email
//            let userToken = appleIDCredential.identityToken
//
//            print(userIdentifier)
//            print(userFirstName)
//            print(userLastName)
//            print(userEmail)
//            print("User token:\(userToken.)")
//            print(userToken?.hashValue)
//
//                // navigate to other view controller
//            }
    }
    
    //If authorization faced any issue then this method will get triggered
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        //If there is any error will get it here
        print("Error In Credential")
    }
}
