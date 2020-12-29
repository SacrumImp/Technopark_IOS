//
//  ThemeModel.swift
//  pin-note
//
//  Created by Алексей Савельев on 29.12.2020.
//

import UIKit


class ThemeCell: UITableViewCell {

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// перечисление полей секции
enum MainThemeSection: Int, CaseIterable, CustomStringConvertible {
    case Gray
    case Dust

    
    var description: String {
        switch self {
        case .Gray: return "Серебро"
        case .Dust: return "Пески"
        }
    }
}
