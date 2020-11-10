//
//  SettingsModel.swift
//  travel-note
//
//  Created by Алексей Савельев on 10.11.2020.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Auth
    case Other
    
    var description: String {
        switch self {
        case .Auth: return "Авторизация"
        case .Other: return "Остальное"
        }
    }
}

enum AuthSection: Int, CaseIterable, CustomStringConvertible {
    case logIn
    case logOut
    
    var description: String {
        switch self {
        case .logIn: return "Войти"
        case .logOut: return "Выйти"
        }
    }
}

enum OtherSection: Int, CaseIterable, CustomStringConvertible {
    case some1
    case some2
    case some3
    
    var description: String {
        switch self {
        case .some1: return "Остальное 1"
        case .some2: return "Остальное 2"
        case .some3: return "Остальное 3"
        }
    }
}


