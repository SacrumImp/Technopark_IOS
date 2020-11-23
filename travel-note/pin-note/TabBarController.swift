//
//  TabBarController.swift
//  travel-note
//
//  Created by Владислав Алпеев on 01.11.2020.
//

import UIKit

class TabBarController: UITabBarController {
    
    // перед появлением определяем на какой странице будет открыт tab bar
    override func viewWillAppear(_ animated: Bool) {
        if Common.Settings.WasTerminated == true {
            self.selectedIndex = Common.Settings.StartingHomePage
            Common.Settings.WasTerminated = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapVC = MapViewController()
        let mapVCViewModel = MapViewModel()
        mapVC.viewModel = mapVCViewModel
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(systemName: "map"), tag: 0) //STRINGS:

        
        let listVC = ListNotesViewController()
        listVC.tabBarItem = UITabBarItem(title: "Список", image: UIImage(systemName: "doc.text"), tag: 1) //STRINGS:
        
        
        self.viewControllers = [mapVC, listVC]
        
    
        
    }
    
    
}
