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

// перечисление секций Настроек
enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Auth
    case Main
    case Conf
    case DataControl
    case Info
    
    var description: String {
        switch self {
        case .Auth: return "Авторизация"
        case .Main: return "Остальное"
        case .Conf: return "Безопасность"
        case .DataControl: return "Управление данными"
        case .Info: return "Информация"
        }
    }
}

// пункты в секции "Авторизация"
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

// пункты в секции "Отновное"
enum MainSection: Int, CaseIterable, CustomStringConvertible {
    case theme
    case firstScreen
    case other
    
    var description: String {
        switch self {
        case .theme: return "Тема"
        case .firstScreen: return "Начальный экран"
        case .other: return "Другое"
        }
    }
}

// пункты в секции "Безопасность"
enum ConfidentialitySection: Int, CaseIterable, CustomStringConvertible {
    case password
    case changePassword
    
    var description: String {
        switch self {
        case .password: return "Защита паролем"
        case .changePassword: return "Изменение пароля"
        }
    }
}

// пункты в секции "Управление данными"
enum DataControlSection: Int, CaseIterable, CustomStringConvertible {
    case password
    case changePassword
    
    var description: String {
        switch self {
        case .password: return "Защита паролем"
        case .changePassword: return "Изменение пароля"
        }
    }
}

// пункты в секции "Информация"
enum InfoSection: Int, CaseIterable, CustomStringConvertible {
    case about
    case feedBack
    
    var description: String {
        switch self {
        case .about: return "О PinNote"
        case .feedBack: return "Обратная связь"
        }
    }
}


