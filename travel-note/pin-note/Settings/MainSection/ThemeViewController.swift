//
//  ThemeViewController.swift
//  pin-note
//
//  Created by Алексей Савельев on 29.12.2020.
//

import UIKit

class ThemeViewController: UIViewController {

    private var tableView: UITableView!
    
    private var theme = ThemeManager.currentTheme()
    
    private var indexPathRemider: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.backgroundColor = theme.tableCellColor
        
        tableView.register(ThemeCell.self, forCellReuseIdentifier: "ThemeCell")
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        tableView.largeContentTitle = "Темы"
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
        
        navigationItem.title = "Выбор темы"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Применить", style: .done, target: self, action: #selector(dismissSelf))
    }
    @objc func dismissSelf() {
        Common.Settings.SelectedTheme = indexPathRemider
        ThemeManager.applyTheme(theme: Theme(rawValue: indexPathRemider)!)
        self.view.layoutIfNeeded()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Расширение
extension ThemeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // ВЫСОТА ЗАГОЛОВКА СЕКЦИИ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 55
    }
    
    // ЗАПОЛНЕНИЕ ЯЧЕЕК
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as? ThemeCell else {return UITableViewCell()}

        cell.backgroundColor = self.theme.tableCellColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.blue
        
        let cellText = MainThemeSection(rawValue: indexPath.row)
        cell.textLabel?.text = cellText?.description
        
        if (Common.Settings.SelectedTheme == indexPath.row) {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        }
        
        return cell
    }
    
    // ОБРАБАТЫВАЕМ ВЫБОР ЯЧЕЙКИ
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        indexPathRemider = indexPath.row
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)

        
    }
}
