//
//  LoginManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 25/02/2023.
//

import UIKit
import FacebookLogin
import FirebaseAuth

@MainActor
struct WLoginManager {
    static func signIn(email: String, password: String) {
        FirebaseManager.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                LocalUserManager.shared.fetchUser { userDataReady in
                    switch userDataReady {
                    case true:
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                    case false:
                        print("FAIL")
                    }
                }
            case .failure(let failure):
                print("There was an error: \(failure.localizedDescription)")
            }
        }
    }
    
    static func createAccount(email: String, password: String) {
        FirebaseManager.shared.createAccount(email: email, password: password) { result in
            switch result {
            case .success:
                LocalUserManager.shared.fetchUser { userDataReady in
                    switch userDataReady {
                    case true:
                       (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                    case false:
                        print("FAIL")
                    }
                }
                
            case .failure(let failure):
                print("There was an error creating user: \(failure.localizedDescription)")
            }
        }
    }
    
    static func signInFacebook() {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["email"], from: nil) { result, error in
            if let error = error {
                print("Encountered Error: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Task {
                    do {
                        try await FirebaseManager.shared.signInByFacebook(credential: credential)
                        LocalUserManager.shared.fetchUser { userDataReady in
                            switch userDataReady {
                            case true:
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                            case false:
                                print("FAIL")
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    static func signInApple() {
        
    }
    
    static func signInGoole() {
        
    }
}
