////
////  User.swift
////  Watudo
////
////  Created by Sebastian Hajduk on 04/12/2022.
////
//
import UIKit

class LocalUser {
    var name: String = ""
    let email = ""
    
    var activities: [Activity] = [Activity(name: "House chores", category: Category(name: "Home")), Activity(name: "Working", category: Category(name: "Work"))]
    var categories: [Category] = [Category(name: "Home"), Category(name: "Work")]
    
    func getActivitiesForCategory(_ category: Category) -> [Activity] {
        var filteredActivities: [Activity] = []
        
        for activity in activities {
            if activity.category == category {
                filteredActivities.append(activity)
            }
        }
        print(filteredActivities)
        return filteredActivities
    }
}
