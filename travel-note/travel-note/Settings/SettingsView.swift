//
//  SettingsView.swift
//  travel-note
//
//  Created by Алексей Савельев on 10.11.2020.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "SettingsCell"

class SettingsView: UIViewController {
    
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        tableView.largeContentTitle = "Настройки"
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
        
        // следующиее почему то не хочет работать (
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationItem.title = "Настройки"
    }
}

extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else {return 0}
        
        switch section {
        case .Auth: return 1
        case .Other: return OtherSection.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        
        let title  = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
    
        guard let section = SettingsSection(rawValue: indexPath.section) else {return UITableViewCell()}
        
        switch section {
        case .Auth:
            let cellText: String = {
                print(FirebaseAuth.Auth.auth().currentUser == nil)
                if FirebaseAuth.Auth.auth().currentUser == nil{
                    return AuthSection.logIn.description
                } else {
                    return AuthSection.logOut.description
                }
            }()
            cell.textLabel?.text = cellText
        case .Other:
            let other = OtherSection(rawValue: indexPath.row)
            cell.textLabel?.text = other?.description
        }
        
        
        return cell
    }
    
    
}
    
