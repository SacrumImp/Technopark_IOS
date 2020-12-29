//
//  ThemeManager.swift
//  pin-note
//
//  Created by Алексей Савельев on 19.12.2020.
//

import UIKit
import Foundation

//TODO: задать темы тут, добавить view в настройки для выбора текущей темы, добавить сетап цветов через thememanager для каждого UI элемента проекта
extension UIColor {
    func colorFromHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
enum Theme: Int {

    case gray, dust

    var mainColor: UIColor {
        switch self {
        case .gray:
            return .black
        case .dust:
            return .white
        }
    }

    //Customizing the Navigation Bar
    var barStyle: UIBarStyle {
        switch self {
        case .gray:
            return .black
        case .dust:
            return .black
        }
    }
    
    var barButtons: UIColor {
        switch self {
        case .gray:
            return .white
        case .dust:
            return UIColor().colorFromHexString("423730")
        }
    }
    
    var firstColor: UIColor {
        switch self {
        case .gray:
            return .darkGray
        case .dust:
            return UIColor(red: 145/255, green: 138/255, blue: 118/255, alpha: 1)
        }
    }
    
    var secondColor: UIColor {
        switch self {
        case .gray:
            return .gray
        case .dust:
            return UIColor(red: 184/255, green: 174/255, blue: 147/255, alpha: 1)
        }
    }
    
    var thirdColor: UIColor {
        switch self {
        case .gray:
            return .lightGray
        case .dust:
            return UIColor(red: 235/255, green: 225/255, blue: 195/255, alpha: 1)
        }
    }
    
    var fourthColor: UIColor {
        switch self {
        case .gray:
            return .white
        case .dust:
            return UIColor(red: 235/255, green: 225/255, blue: 195/255, alpha: 1)
        }
    }
    var tableCellColor: UIColor {
        switch self {
        case .gray:
            return .white
        case .dust:
            return UIColor(red: 235/255, green: 225/255, blue: 195/255, alpha: 1)
        }
    }
    
    var titleTextColor: UIColor {
        switch self {
        case .gray:
            return .black
        case .dust:
            return UIColor().colorFromHexString("000000")
        }
    }
    
    var subtitleTextColor: UIColor {
        switch self {
        case .gray:
            return UIColor().colorFromHexString("ffffff")
        case .dust:
            return UIColor().colorFromHexString("000000")
        }
    }
    
    var secondTextColor: UIColor {
        switch self {
        case .gray:
            return .white
        case .dust:
            return .white
        }
    }
}

// Enum declaration
let SelectedThemeKey = "selectedTheme"

// This will let you use a theme in the app.
class ThemeManager {

    // ThemeManager
    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .gray
        }
    }

    static func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()

        // You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UILabel.appearance().textColor = theme.titleTextColor

        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().barTintColor = theme.firstColor
        UINavigationBar.appearance().tintColor = theme.barButtons

        //UITabBar.appearance().barStyle = theme.barStyle
        //UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage

        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
        let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
        

        UISegmentedControl.appearance().backgroundColor = theme.firstColor
        UISegmentedControl.appearance().backgroundColor = theme.secondColor

    }
}
