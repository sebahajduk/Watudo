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
class FirebaseManager {
    static let shared = FirebaseManager()
    
    var user: FirebaseAuth.User?
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    
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
extension FirebaseManager {
    private func createDefaultDatabase() {
        let userActivitiesList = db.collection("Users").document("\(user!.uid)").collection("Activities")
        let userCategoriesList = db.collection("Users").document("\(user!.uid)").collection("Categories")
        
        let defaultJobCategory: Category = Category(name: "Work")
        let defaultHomeCategory: Category = Category(name: "House")
        
        let defaultHomeActivity: Activity = Activity(name: "House chores", category: defaultHomeCategory)
        let defaultJobActivity: Activity = Activity(name: "Working", category: defaultJobCategory)
        
        do {
            try userCategoriesList.document(defaultHomeCategory.name).setData(from: defaultHomeCategory)
            try userCategoriesList.document(defaultJobCategory.name).setData(from: defaultJobCategory)
            
            try userActivitiesList.document(defaultHomeActivity.name).setData(from: defaultHomeActivity)
            try userActivitiesList.document(defaultJobActivity.name).setData(from: defaultJobActivity)
        } catch {
            print("There was an error creating default database.")
        }
    }
    
    func saveActivity(_ activity: Activity) {
        let daysHistory = db.collection("Users").document("\(user!.uid)").collection("Days")
        let endDate = activity.endDate!.dateToStringYMD()
        let endHours = activity.endDate!.dateToStringHMS()
        
        do {
            try daysHistory.document("\(endDate)").collection("Activities").document("\(UUID())").setData(from: activity)
        } catch {
            print("There was an error creating default database.")
        }
    }
}
