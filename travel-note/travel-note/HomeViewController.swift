//
//  HomeViewController.swift
//  travel-note
//
//  Created by Алексей Савельев on 26.10.2020.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    let lable: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 0, width: 300, height: 100))
        lable.text = "Hello!" //STRINGS:
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let lableVC: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 50, width: 300, height: 100))
        lable.text = "MapVC" //STRINGS:
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let authentificationButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 180, y: 50, width: 300, height: 100))
        if FirebaseAuth.Auth.auth().currentUser != nil {
            button.setTitle("Выход", for: .normal) //STRINGS:
        }
        else{
            button.setTitle("Авторизация", for: .normal) //STRINGS:
        }
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(lable)
        lable.center = view.center
        
        view.addSubview(lableVC)
        lableVC.center.x = self.view.center.x
        
        view.addSubview(authentificationButton)
        authentificationButton.addTarget(self, action: #selector(useAuthentification(sender:)), for: .touchUpInside)
    }
    
    @objc func useAuthentification(sender: UIButton) {
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            do{
                try FirebaseAuth.Auth.auth().signOut()
            }
            catch{
                print("Error sign out") //STRINGS:
            }
            authentificationButton.setTitle("Авторизация", for: .normal) //STRINGS:
        }
        let viewController = Authentication_Phone()
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .automatic
        self.present(viewController, animated: true)
    }
}
