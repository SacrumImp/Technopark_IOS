//
//  ThemeViewController.swift
//  pin-note
//
//  Created by Алексей Савельев on 29.12.2020.
//

import UIKit

class ThemeViewController: UIViewController {

    private let theme = ThemeManager.currentTheme()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
        
        // инит
        let items = ["Gray", "Dust"]
        let SC = UISegmentedControl(items: items)
        SC.selectedSegmentIndex = Common.Settings.SelectedTheme
        
        // рамка
        let frame = UIScreen.main.bounds
        SC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 25,
                                width: frame.width - 30, height: frame.height*0.05)
        
        // углы и цвет
        SC.layer.cornerRadius = 4.0
        SC.backgroundColor = theme.firstColor
        SC.tintColor = theme.secondColor

        // обработка изменения значения
        SC.addTarget(self, action: #selector(sgDidSwich(sender:)), for: .valueChanged)

        self.view.addSubview(SC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.fourthColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Применить", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(dismissSelf))
    }
    
    // обработка изменения значения SC
    @objc func sgDidSwich(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Common.Settings.SelectedTheme = Int(sender.selectedSegmentIndex)
            ThemeManager.applyTheme(theme: Theme(rawValue: Int(sender.selectedSegmentIndex))!)
            self.view.layoutIfNeeded()
        case 1:
            Common.Settings.SelectedTheme = Int(sender.selectedSegmentIndex)
            ThemeManager.applyTheme(theme: Theme(rawValue: Int(sender.selectedSegmentIndex))!)
            self.view.layoutIfNeeded()
        default:
            print("gg")
        }
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

}
