//
//  FirstScreenViewController.swift
//  travel-note
//
//  Created by Алексей Савельев on 13.11.2020.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    private let theme = ThemeManager.currentTheme()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
        
        // инит
        let items = ["Карта", "Список"]
        let SC = UISegmentedControl(items: items)
        SC.selectedSegmentIndex = Common.Settings.StartingHomePage == 2 ? Common.Settings.StartingHomePage - 1 : Common.Settings.StartingHomePage
        
        // рамка
        let frame = UIScreen.main.bounds
        SC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 25,
                                width: frame.width - 30, height: frame.height*0.05)
        
        // углы и цвет
        SC.layer.cornerRadius = 4.0
        SC.backgroundColor = theme.barTintColor
        SC.tintColor = theme.secondaryColor

        // обработка изменения значения
        SC.addTarget(self, action: #selector(sgDidSwich(sender:)), for: .valueChanged)

        self.view.addSubview(SC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.secondaryColor
    }
    
    // обработка изменения значения SC
    @objc func sgDidSwich(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Common.Settings.StartingHomePage = Int(sender.selectedSegmentIndex)
        case 1:
            Common.Settings.StartingHomePage = Int(sender.selectedSegmentIndex + 1)
        default:
            print("gg")
        }
    }

}
