//
//  UserManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 29/01/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FacebookLogin

/// Everything sticked to user account (Login, creating account, signing out)
class FirebaseManager {
    static let shared = FirebaseManager()
    
    var user: FirebaseAuth.User?
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    
    var localUser: LocalUser?
    
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
                self.user = authResult.user
                completion(.success(authResult))
            }
        }
    }
    
    func signInByFacebook(credential: AuthCredential) async throws {
        
        do {
            let authResult = try await auth.signIn(with: credential)
            let isNewUser = authResult.additionalUserInfo?.isNewUser
            self.user = authResult.user
            if isNewUser! {
                self.createDefaultDatabase()
            }
            print(user?.uid)
        } catch {
            print("There was an error signing in.")
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

/// Download user
extension FirebaseManager {
    
    func fetchUser(_ completion: @escaping (Result<LocalUser, Error>) -> Void) {
        var activitiesList: [Activity] = []
        var categories: [Category] = []
        
        fetchActivityList { result in
            switch result {
            case .success(let fetchedActivities):
                activitiesList = fetchedActivities
                
                self.fetchCategoryList { result in
                    switch result {
                    case .success(let fetchedCategories):
                        categories = fetchedCategories
                        completion(.success(LocalUser(activities: activitiesList, categories: categories)))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    private func fetchActivityList(_ completion: @escaping (Result<[Activity], any Error>) -> Void) {
        let userDoc = db.collection("Users").document("\(user!.uid)")
        let userActivitiesList = userDoc.collection("Activities")
        var activities: [Activity] = []
        
        userActivitiesList.getDocuments { (querySnapshot, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            for document in querySnapshot!.documents {
                do {
                    let activity = try document.data(as: Activity.self)
                    activities.append(activity)
                } catch  {
                    completion(.failure(error))
                }
            }
            completion(.success(activities))
        }
    }
    
    private func fetchCategoryList(_ completion: @escaping (Result<[Category], any Error>) -> Void) {
        let userDoc = db.collection("Users").document("\(user!.uid)")
        let userCategoryList = userDoc.collection("Categories")
        var categories: [Category] = []
        
        userCategoryList.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                for doc in querySnapshot!.documents {
                    do {
                        let category = try doc.data(as: Category.self)
                        categories.append(category)
                    } catch {
                        completion(.failure(error))
                    }
                }
                completion(.success(categories))
            }
        }
    }
    
    func getLastWeekHistory(_ completion: @escaping (Result<[String : [Activity]], any Error>) -> Void) {
        let daysHistory = db.collection("Users").document("\(user!.uid)").collection("Days")
        var dates: [String] = []
        var lastWeekHistory: [String:[Activity]] = [:]
        
        for i in 0...6 {
            let day = Calendar.current.date(byAdding: .day, value: -i, to: Date())
            let dateString = day!.dateToStringYMD()
            dates.append(dateString)
        }
        
        daysHistory.whereField("id", in: dates).getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                for document in querySnapshot!.documents {
                    let day = document.documentID
                    let docRef = document.reference.collection("Activities")
                    
                    docRef.getDocuments { (querySnap, error) in
                        if let error = error {
                            print("Error: \(error)")
                        } else {
                            var activitiesList: [Activity] = []
                            
                            ///doc is single activity in specified day (document).
                            for doc in querySnap!.documents {
                                do {
                                    let activity = try doc.data(as: Activity.self)
                                    activitiesList.append(activity)
                                } catch {
                                    print("Erro")
                                }
                            }
                            lastWeekHistory[day] = activitiesList
                        }
                        if querySnapshot!.documents.first == document {
                            completion(.success(lastWeekHistory))
                        }
                    }
                }
            }
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
    
    func delete<T: Addable & Codable>(_ object: T, completion: @escaping (Bool) -> Void) {
        let userDoc = db.collection("Users").document("\(user!.uid)")
        let userActivitiesList = userDoc.collection("Activities")
        let userCategoriesList = userDoc.collection("Categories")
        
        if object is Category {
            userCategoriesList.document(object.name).delete { error in
                guard error == nil else {
                    completion(false)
                    return
                }
            }
            completion(true)
        } else if object is Activity {
            userCategoriesList.document(object.name).delete { error in
                guard error == nil else {
                    completion(false)
                    return
                }
            }
            completion(true)
        }
    }
}
