//
//  LoginManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 25/02/2023.
//

import UIKit
import FirebaseCore
import FacebookLogin
import FirebaseAuth
import GoogleSignIn

@MainActor
struct WLoginManager {
    static func signIn(email: String, password: String, completion: @escaping (Error?) -> ()) {
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
                completion(failure)
            }
        }
    }
    
    static func createAccount(email: String, password: String, name: String, completion: @escaping (Error?) -> ()) {
        FirebaseManager.shared.createAccount(email: email, password: password, name: name) { result in
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
                completion(failure)
            }
        }
    }
    
    static func signInFacebook(completion: @escaping (Error?) -> ()) {
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
                        try await FirebaseManager.shared.signInByPlatforms(credential: credential)
                        LocalUserManager.shared.fetchUser { userDataReady in
                            switch userDataReady {
                            case true:
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                            case false:
                                print("FAIL")
                            }
                        }
                    } catch {
                        completion(error)
                    }
                }
            }
        }
    }
    
    static func signInApple() {
        
    }
    
    static func signInGoogle(viewController: UIViewController, completion: @escaping (Error?) -> ()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Task {
                do {
                    try await FirebaseManager.shared.signInByPlatforms(credential: credential)
                    LocalUserManager.shared.fetchUser { userDataReady in
                        switch userDataReady {
                        case true:
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                        case false:
                            print("FAIL")
                        }
                    }
                }
            }
        }
    }
    
}
