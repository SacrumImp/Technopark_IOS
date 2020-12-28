//
//  ListNotes.swift
//  travel-note
//
//  Created by Владислав Алпеев on 01.11.2020.
//

import UIKit

class ListNotesViewController: UIViewController {
    
    var viewModel: ListNotesViewModelProtocol!
    
    private let label: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 0, width: 300, height: 100))
        lable.text = "Hello!" //STRINGS:
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    private let labelVC: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 50, width: 300, height: 100))
        lable.text = "ListNotes" //STRINGS:
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    private let testSettingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 280, y: 80, width: 120, height: 35))
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal) //красным чтоб заметно было
        button.layer.backgroundColor = UIColor.systemRed.cgColor.copy(alpha: 0.3)
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(label)
        label.center = self.view.center
        
        view.addSubview(labelVC)
        labelVC.center.x = self.view.center.x
        
        view.addSubview(testSettingsButton)
        testSettingsButton.addTarget(self, action: #selector(openSettings(sender:)), for: .touchUpInside)
        
        print(viewModel.getNotes())
    }
    
    @objc private func openSettings(sender: UIButton) {
        let settingsView = SettingsViewController()
        let navVC = UINavigationController(rootViewController: settingsView)
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }

}
