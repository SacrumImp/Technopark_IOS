//
//  ViewController.swift
//  travel-note
//
//  Created by Владислав Алпеев on 17.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageViewText: UIImageView = {
        let imageViewLogo = UIImageView(frame: CGRect(x: 146, y: 542, width: 123, height: 27))
        imageViewLogo.image = UIImage(named: "logoText")
        return imageViewLogo
    }()
    
    private let imageViewLogo: UIImageView = {
        let imageViewLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageViewLogo.image = UIImage(named: "loadScreenLogo")
        return imageViewLogo
    }()
    
    private let imageViewBG: UIImageView = {
        let imageViewBG = UIImageView(frame: CGRect(x: 0, y: 0, width: 414, height: 896))
        imageViewBG.image = UIImage(named: "loadScreenBG")
        return imageViewBG
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageViewBG)
        view.addSubview(imageViewText)
        view.addSubview(imageViewLogo)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageViewLogo.center = view.center
        imageViewBG.contentMode = .scaleAspectFill
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute:    {
            self.animate()
        })
    }
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageViewLogo.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageViewLogo.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    let viewController = HomeViewController()
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true)
                })
            }
        })
        
    }


}

