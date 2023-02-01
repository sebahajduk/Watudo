//
//  UserDefaults.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 31/01/2023.
//

import UIKit

enum TimeZones: Codable {
    case AMPM, GMT
}

class Defaults {
    static let shared = Defaults()
    
    let defaults = UserDefaults.standard
    
    var isDarkMode: Bool {
        set {
            defaults.setValue(newValue, forKey: "isDarkMode")
            
        }
        get {
            return defaults.bool(forKey: "isDarkMode")
        }
    }
    
    
    var timeZone: TimeZones? {
        set {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)
                
                defaults.setValue(data, forKey: "timeZone")
            } catch {
                print("There was an error saving time zone. Please try again later.")
            }
        }
        
        get {
            if let data = defaults.data(forKey: "timeZone") {
                do {
                    let decoder = JSONDecoder()
                    let userTimeZone = try decoder.decode(TimeZones.self, from: data)
                    
                    return userTimeZone
                } catch {
                    print("There was an error fetching data. Please try again later.")
                    return nil
                }
            }
            return nil
        }
    }
    
    
    var areNotificationsOn: Bool {
        set {
            defaults.setValue(newValue, forKey: "areNotificationsOn")
        }
        
        get {
            return defaults.bool(forKey: "areNotificationsOn")
        }
    }
    
    
    var notificationInterval: Double {
        set {
            defaults.setValue(newValue, forKey: "notificationInterval")
        }
        
        get {
            return defaults.double(forKey: "notificationInterval")
        }
    }
    
    
}
