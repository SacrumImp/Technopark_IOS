//
//  Common.swift
//  travel-note
//
//  Created by Алексей Савельев on 13.11.2020.
//

import UIKit

class Common: NSObject {
    struct Settings {
        
        private enum SettingKeys: String {
            case startingHomePage
        }
        
        static var StartingHomePage: Int {
            set {
                UserDefaults.standard.set(newValue, forKey: SettingKeys.startingHomePage.rawValue)
            }
            get {
                return UserDefaults.standard.integer(forKey: SettingKeys.startingHomePage.rawValue)
            }
        }
    }
}
