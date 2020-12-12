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
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(named: "tabbar-map-icon.svg"), tag: 0) //STRINGS:

        
        let listVC = ListNotesViewController()
        listVC.tabBarItem = UITabBarItem(title: "Список", image: UIImage(named: "tabbar-list-icon.svg"), tag: 1) //STRINGS:
        
        self.viewControllers = [mapVC, listVC]
        
        tabbarConfig() //настройка внешнего вида таббара
    
    }
    
    private func tabbarConfig() {

        self.tabBar.isTranslucent = true
        self.tabBar.backgroundImage = UIImage()
        //self.tabBar.shadowImage = UIImage() // раскоменть и удалишь разделитель
        self.tabBar.barTintColor = .clear
        self.tabBar.layer.backgroundColor = UIColor.clear.cgColor

        let blurEffect = UIBlurEffect(style: .light) // изменение стиля размытия
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tabBar.insertSubview(blurView, at: 0)
    }
    
}
