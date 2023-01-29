//
//  UserManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 29/01/2023.
//

import Foundation

struct UserManager {
    
    static func addActivity(user: User, activity: Activity) {
        guard let index = user.categories.firstIndex(where: {$0.name == activity.category?.name }) else { return }
        
        user.categories[index].activities.append(activity)
        for category in user.categories {
            print("Name: \(category.name), Activities: \(category.activities.count)")
        }
    }
    
}
