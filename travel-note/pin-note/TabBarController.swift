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
        
        
        //tabBar.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
    
        
        let mapVC = HomeViewController()
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(systemName: "map"), tag: 0) //STRINGS:
        
        
        let listVC = ListNotesViewController()
        listVC.tabBarItem = UITabBarItem(title: "Список", image: UIImage(systemName: "doc.text"), tag: 1) //STRINGS:
        
        
        self.viewControllers = [mapVC, listVC]
        
    
        
    }
    
    
}
