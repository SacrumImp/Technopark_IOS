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
        lable.text = "Hello!"
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let authentificationButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 15, width: 300, height: 100))
        button.setTitle("Авторизация", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lable)
        view.addSubview(authentificationButton)
        authentificationButton.addTarget(self, action: #selector(useAuthentification(sender:)), for: .touchUpInside)
        view.backgroundColor = .systemBackground
        lable.center = view.center
    }
    
    @objc func useAuthentification(sender: UIButton) {
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            do{
                try FirebaseAuth.Auth.auth().signOut()
            }
            catch{
                print("Error sign out")
            }
            authentificationButton.setTitle("Авторизация", for: .normal)
        }
        let viewController = Authentication_Phone()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }

}
