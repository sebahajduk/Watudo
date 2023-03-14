//
//  WLoginManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 25/02/2023.
//

import UIKit
import FirebaseCore
import FacebookLogin
import FirebaseAuth
import GoogleSignIn
import CryptoKit
import AuthenticationServices

@MainActor
struct WLoginManager {
    static func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        FirebaseManager.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                LocalUserManager.shared.fetchUser { userDataReady in
                    switch userDataReady {
                    case true:
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                            .changeRootViewController(TabBarController())
                    case false:
                        print("FAIL")
                    }
                }
            case .failure(let failure):
                completion(failure)
            }
        }
    }

    static func createAccount(email: String, password: String, name: String, completion: @escaping (Error?) -> Void) {
        FirebaseManager.shared.createAccount(email: email, password: password, name: name) { result in
            switch result {
            case .success:
                LocalUserManager.shared.fetchUser { userDataReady in
                    switch userDataReady {
                    case true:
                       (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                            .changeRootViewController(TabBarController())
                    case false:
                        print("FAIL")
                    }
                }
            case .failure(let failure):
                completion(failure)
            }
        }
    }

    static func signInFacebook(completion: @escaping (Error?) -> Void) {
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
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                                    .changeRootViewController(TabBarController())
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

    func signInApple<T: ASAuthorizationControllerDelegate &
                        ASAuthorizationControllerPresentationContextProviding &
                        UIViewController>(_ object: T, currentNonce: inout String?) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = object.self
        authorizationController.presentationContextProvider = object.self
        authorizationController.performRequests()
    }

    static func initializeCredentials(with authorization: ASAuthorization,
                                      currentNonce: String?,
                                      completion: @escaping (Error?) -> Void) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }

            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }

            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            Task {
                do {
                    try await FirebaseManager.shared.signInWithApple(idTokenString: idTokenString, nonce: nonce)
                    LocalUserManager.shared.fetchUser { userDataReady in
                        switch userDataReady {
                        case true:
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                                .changeRootViewController(TabBarController())
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

    static func signInGoogle(viewController: UIViewController, completion: @escaping (Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            guard error == nil else {
                completion(error)
                return
            }

            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            Task {
                do {
                    try await FirebaseManager.shared.signInByPlatforms(credential: credential)
                    LocalUserManager.shared.fetchUser { userDataReady in
                        switch userDataReady {
                        case true:
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                                .changeRootViewController(TabBarController())
                        case false:
                            print("FAIL")
                        }
                    }
                }
            }
        }
    }
}

// MARK: Utilities for Sign in with Apple
extension WLoginManager {
    fileprivate func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    fileprivate func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }
}
