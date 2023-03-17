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

    var isDarkMode: Bool? {
        get {
            return defaults.bool(forKey: "isDarkMode")
        }

        set {
            defaults.setValue(newValue, forKey: "isDarkMode")

        }
    }

    var timeZone: TimeZones? {
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

        set {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)

                defaults.setValue(data, forKey: "timeZone")
            } catch {
                print("There was an error saving time zone. Please try again later.")
            }
        }
    }

    var areNotificationsOn: Bool {
        get {
            return defaults.bool(forKey: "areNotificationsOn")
        }

        set {
            defaults.setValue(newValue, forKey: "areNotificationsOn")
        }
    }

    var notificationInterval: Double {
        get {
            return defaults.double(forKey: "notificationInterval")
        }

        set {
            defaults.setValue(newValue, forKey: "notificationInterval")
        }
    }
}
