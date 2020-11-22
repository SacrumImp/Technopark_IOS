//
//  TabBarController.swift
//  travel-note
//
//  Created by Владислав Алпеев on 01.11.2020.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapVC = MapViewController()
        let mapVCViewModel = MapViewModel()
        mapVC.viewModel = mapVCViewModel
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage.add, tag: 0) //STRINGS:
        
        let listVC = ListNotesViewController()
        listVC.tabBarItem = UITabBarItem(title: "Список", image: UIImage.actions, tag: 1) //STRINGS:
        
        self.viewControllers = [mapVC, listVC]
        
    }
    
    
}
