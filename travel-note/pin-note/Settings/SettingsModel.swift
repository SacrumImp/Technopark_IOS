//
//  SettingsModel.swift
//  travel-note
//
//  Created by Алексей Савельев on 10.11.2020.
//

import UIKit

class SettingsCell: UITableViewCell {

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
    case DataControl
    case Info
    
    var description: String {
        switch self {
        case .Auth: return "Авторизация"
        case .Main: return "Главное"
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
    
    var description: String {
        switch self {
        case .theme: return "Тема"
        case .firstScreen: return "Начальный экран"
        }
    }
}

// пункты в секции "Управление данными"
enum DataControlSection: Int, CaseIterable, CustomStringConvertible {
    case sync
    case backup
    
    var description: String {
        switch self {
        case .sync: return "Синхронизация"
        case .backup: return "Восстановить данные"
        }
    }
}

// пункты в секции "Информация"
enum InfoSection: Int, CaseIterable, CustomStringConvertible {
    case about
    case feedBack
    
    var description: String {
        switch self {
        case .about: return "О Приложении"
        case .feedBack: return "Оставить отзыв"
        }
    }
}


