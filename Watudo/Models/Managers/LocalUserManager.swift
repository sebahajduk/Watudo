//
//  LocalUserManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 21/02/2023.
//

import UIKit


class LocalUserManager {
    static let shared = LocalUserManager()
    private var user: LocalUser!
    
    func addCategory(_ category: Category) {
        user.categories.append(category)
    }
    
    func addActivity(_ activity: Activity) {
        user.activities.append(activity)
        FirebaseManager.shared.add(activity)
    }
    
    func finishWork(at indexPath: IndexPath) {
        let activity = getActivitiesForCategory(at: indexPath.section)[indexPath.row].finishWork()
        FirebaseManager.shared.saveActivity(activity)
    }
    
    func startWork(at indexPath: IndexPath) {
        let activities = getActivitiesForCategory(at: indexPath.section)
        
        activities[indexPath.row].startWork()
    }
    
    func removeActivity(at indexPath: IndexPath) {
        let activity = getActivitiesForCategory(at: indexPath.section)[indexPath.row]
        
        FirebaseManager.shared.delete(activity) { isDeleted in
            if isDeleted {
                guard let index = self.user.activities.firstIndex(where: { $0 == activity}) else { return }
                self.user.activities.remove(at: index)
            } else {
                print("There was an error deleting activity. Please try again.")
            }
        }
    }
}

//MARK: Getters
extension LocalUserManager {
    func getCategory(for section: Int) -> Category {
        user.categories[section]
    }
    
    func getActivities() -> [Activity] {
        user.activities
    }
    
    func getNumberOfCategories() -> Int {
        user.categories.count
    }
    
    func getCategories() -> [Category] {
        user.categories
    }
    
    func getActivitiesForCategory(at section: Int) -> [Activity] {
        let category = user.categories[section]

        var filteredActivities: [Activity] = []
        
        for activity in user.activities {
            if activity.category == category {
                filteredActivities.append(activity)
            }
        }
        
        return filteredActivities
    }
}

//MARK: Preparing user after logging
extension LocalUserManager {
    func fetchUser(_ completion: @escaping (Bool) -> Void) {
       FirebaseManager.shared.fetchUser({ result in
            switch result {
            case .success(let localUser):
                self.user = localUser
                print(self.user.categories)
                completion(true)
            case .failure:
                completion(false)
            }
        })
    }
}
