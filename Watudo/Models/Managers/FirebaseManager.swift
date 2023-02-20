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

/// User data management (activities)
extension FirebaseManager {
    private func createDefaultDatabase() {
        let userDoc = db.collection("Users").document("\(user!.uid)")
        userDoc.setData(["id":user!.uid])
        
        let userActivitiesList = userDoc.collection("Activities")
        let userCategoriesList = userDoc.collection("Categories")
        
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
        
        ///Creating date parameters to be visibile for queries.
        daysHistory.document("\(endDate)").setData(["id": endDate])
        
        ///Saving activity
        do {
            try daysHistory.document("\(endDate)").collection("Activities").document("\(UUID())").setData(from: activity)
        } catch {
            print("There was an error creating default database.")
        }
    }
    
    
    /// Fetching data about acitivities history.
    /// - Parameter completion: handling dictionary - as a key uses date in format "yyyy-MM-dd".
    func fetchActivitiesByDate(completion: @escaping (Result<[String:[Activity]], Error>) -> Void) {
        let days = db.collection("Users").document("\(user!.uid)").collection("Days")
        var history: [String:[Activity]] = [:]
        days.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                /// Document is a single day.
                for document in querySnapshot!.documents {
                    let day = document.documentID
                    let docRef = document.reference.collection("Activities")
                    
                    docRef.getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print("Error: \(error)")
                        } else {
                            var activitiesList: [Activity] = []
                            
                            ///doc is single activity in specified day (document).
                            for doc in querySnapshot!.documents {
                                do {
                                    let activity = try doc.data(as: Activity.self)
                                    activitiesList.append(activity)
                                } catch {
                                    print("Erro")
                                }
                            }
                            history[day] = activitiesList
                        }
                        completion(.success(history))
                    }
                }
            }
        }
    }
    
    func add<T: Addable & Codable>(_ object: T) {
        let userDoc = db.collection("Users").document("\(user!.uid)")
        let userActivitiesList = userDoc.collection("Activities")
        let userCategoriesList = userDoc.collection("Categories")
        
        if object is Category {
            do {
                try userCategoriesList.document(object.name).setData(from: object)
            } catch {
                print("There was an error saving your category.")
            }
        } else if object is Activity {
            do {
                try userActivitiesList.document(object.name).setData(from: object)
            } catch {
                print("There was an error saving your activity.")
            }
        }
    }
    
    
}
