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
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        navigationItem.title = "Настройки"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(dismissSelf))
    }
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
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
        
        view.backgroundColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
        
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
    
    // высота секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
    
    // заполнение ячеек
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
    
    // обрабатываем выбор ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // плавно убираем анимацию выделения ячейки
        tableView.deselectRow(at: indexPath, animated: true)
        
        // получаем ячейку
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        // получаем секцию
        guard let section = SettingsSection(rawValue: indexPath.section) else {return}
        
        
        switch section {
        case .Auth:
            print("tapped in auth section")
            let cellText = cell.textLabel?.text
            //Определяем авторизованны мы или нет по заголовку ячейки
            if cellText == AuthSection.logIn.description {
                //dismiss(animated: true, completion: nil)
                let authentificationViewModel = AuthentificationViewModel()
                let authentificationView = Authentication_Phone()
                authentificationView.viewModel = authentificationViewModel
                authentificationView.modalTransitionStyle = .coverVertical
                authentificationView.modalPresentationStyle = .automatic
                self.present(authentificationView, animated: true)
            } else if cellText == AuthSection.logOut.description {
                do{
                    try FirebaseAuth.Auth.auth().signOut()
                }
                catch{
                    print("Error sign out") //STRINGS:
                }
                print("Signed out")
                cell.textLabel?.text = AuthSection.logIn.description
            }
        case .Other:
            print("tapped in other section")
        }
        
    }
    
    
}
    
