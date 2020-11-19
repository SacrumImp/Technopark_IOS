//
//  Common.swift
//  travel-note
//
//  Created by Алексей Савельев on 13.11.2020.
//

import UIKit

class Common: NSObject {
    struct Settings {
        
        // ключи настроек
        private enum SettingKeys: String {
            case startingHomePage
        }
        
        // сохраняет с UserDefaults стартовый эктан (индекс для таббара (0 и/или 1; или в дальнейшем 2 итд)
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
