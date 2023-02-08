//
//  UserManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 29/01/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

/// Everything sticked to user account (Login, creating account, signing out)
class FirebaseUserManager {
    static let shared = FirebaseUserManager()
    
    var user: FirebaseAuth.User?
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    /// Use this method whenever you want to create new user
    /// - Parameters:
    ///   - email: must be correct email style
    ///   - password: needs to be minimum 6 characters long
    func createAccount(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
                self.user = authResult.user
                self.createDefaultDatabase()
            }
        }
    }
    
    /// Sign in by email and password
    func signIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
                self.user = authResult.user
            }
        }
    }
    
    func signOut() throws {
        do {
            try auth.signOut()
        } catch let err as NSError {
            throw err
        }
    }
}

/// User data managing (activities)
extension FirebaseUserManager {
    private func createDefaultDatabase() {
        let defaultActivity: Activity = Activity(name: "Coding")
        
        do {
            try db.collection("Users").document("\(user!.uid)").collection("Days").document("Activities").setData(from: defaultActivity)
        } catch {
            print("There was an error creating default database.")
        }
    }
}
