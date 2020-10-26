//
//  ViewController.swift
//  travel-note
//
//  Created by Владислав Алпеев on 17.10.2020.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var AccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            AccountButton.setTitle("Выйти", for: .normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @IBAction func useAuthentification(_ sender: Any) {
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            do{
                try FirebaseAuth.Auth.auth().signOut()
            }
            catch{
                print("Error sign out")
            }
            AccountButton.setTitle("Выйти", for: .normal)
        }
    }
    
}

