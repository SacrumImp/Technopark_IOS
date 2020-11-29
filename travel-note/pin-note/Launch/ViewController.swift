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
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageViewLogo.center = view.center
        imageViewBG.contentMode = .scaleAspectFill
        DispatchQueue.main.asyncAfter(deadline: .now()+2.7, execute:    {
            self.animateDismiss()
        })
    }
    
    private func animateDismiss() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.imageViewText.alpha = 0
            
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.imageViewLogo.alpha = 0
                })
            }
        })
        UIView.animate(withDuration: 0.6, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut,  animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size

            self.imageViewLogo.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        }, completion: { done in
            if done {
                let viewController = TabBarController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            }
        })
        
    }
    
}

