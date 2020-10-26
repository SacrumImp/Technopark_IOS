//
//  HomeViewController.swift
//  travel-note
//
//  Created by Алексей Савельев on 26.10.2020.
//

import UIKit

class HomeViewController: UIViewController {

    let lable: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 0, width: 300, height: 100))
        lable.text = "Hello!"
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lable)
        view.backgroundColor = .systemBackground
        
        lable.center = view.center
    }

}
