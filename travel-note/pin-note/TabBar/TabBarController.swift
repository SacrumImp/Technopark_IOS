//
//  TabBarController.swift
//  travel-note
//
//  Created by Владислав Алпеев on 01.11.2020.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{
    
    private var theme = ThemeManager.currentTheme()
    
    // перед появлением определяем на какой странице будет открыт tab bar
    override func viewWillAppear(_ animated: Bool) {
        if Common.Settings.WasTerminated == true {
            self.selectedIndex = Common.Settings.StartingHomePage
            Common.Settings.WasTerminated = false
        }
    }
    
    var mapViewController: MapViewController!
    var addNoteViewController: AddNoteViewController!
    var listViewController: ListNotesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        mapViewController = MapViewController()
        let mapVCViewModel = MapViewModel()
        mapViewController.viewModel = mapVCViewModel
        
        addNoteViewController = AddNoteViewController()
        let addNoteVCViewModel = AddNoteViewModel()
        addNoteViewController.viewModel = addNoteVCViewModel
        
        listViewController = ListNotesViewController()
        let listVCViewModel = ListNotesViewModel()
        listViewController.viewModel = listVCViewModel
        
        
        mapViewController.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(named: "tabbar-map-icon.svg"), tag: 0) //STRINGS:
        listViewController.tabBarItem = UITabBarItem(title: "Список", image: UIImage(named: "tabbar-list-icon.svg"), tag: 2) //STRINGS:
        addNoteViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar-add-icon.svg"), tag: 1) //STRINGS:
        
        self.viewControllers = [mapViewController, addNoteViewController, listViewController]
        
        tabbarConfig() //настройка внешнего вида таббара
    
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
          if viewController.isKind(of: AddNoteViewController.self) {
            let vc =  AddNoteViewController()
            let addNoteVCViewModel = AddNoteViewModel()
            vc.viewModel = addNoteVCViewModel
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalTransitionStyle = .crossDissolve
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true, completion: nil)
            return false
          }
          return true
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
        self.tabBar.barTintColor = theme.mainColor
        
        // кнопка новой заметки
        let addItem = self.tabBar.items![1] as UITabBarItem
        addItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
    }
    
}
