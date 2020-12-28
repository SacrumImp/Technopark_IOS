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
            return UIColor().colorFromHexString("ffffff")
        case .dust:
            return UIColor().colorFromHexString("000000")
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
    
    var barTintColor: UIColor {
        switch self {
        case .gray:
            return .darkGray
        case .dust:
            return UIColor(red: 145/255, green: 138/255, blue: 118/255, alpha: 1)
        }
    }

    var navigationBackgroundImage: UIImage? {
        return self == .gray ? UIImage(named: "navBackground") : nil
    }

    var tabBarBackgroundImage: UIImage? {
        return self == .gray ? UIImage(named: "tabBarBackground") : nil
    }

    var backgroundColor: UIColor {
        switch self {
        case .gray:
            return .gray
        case .dust:
            return UIColor(red: 184/255, green: 174/255, blue: 147/255, alpha: 1)
        }
    }

    var secondaryColor: UIColor {
        switch self {
        case .gray:
            return .lightGray
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
    
    var lableTextColor: UIColor {
        switch self {
        case .gray:
            return .black
        case .dust:
            return UIColor().colorFromHexString("000000")
        }
    }
    var secondaryLableTextColor: UIColor {
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
            return .dust
        }
    }

    static func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()

        // You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UILabel.appearance().textColor = theme.lableTextColor

        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        UINavigationBar.appearance().barTintColor = theme.barTintColor

        //UITabBar.appearance().barStyle = theme.barStyle
        //UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage

        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
        let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator

        let controlBackground = UIImage(named: "controlBackground")?.withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))

        UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
        UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected, barMetrics: .default)

        UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
        UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)

        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
        UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), for: .normal)
        UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), for: .normal)

        UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = theme.mainColor
    }
}
