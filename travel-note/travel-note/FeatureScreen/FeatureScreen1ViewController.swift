//
//  FeatureScreen1ViewController.swift
//  travel-note
//
//  Created by Алексей Савельев on 03.11.2020.
//

import UIKit

class FeatureScreen1ViewController: UIViewController {
    
    private let featuresScrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.indicatorStyle = .white
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .systemBackground
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .gray
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // constrain all 4 sides of the scroll view to the safe area
//        featuresScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0)
//        featuresScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0)
//        featuresScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0)
//        featuresScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0)
        
        view.backgroundColor = .systemBackground
        
        featuresScrollView.backgroundColor = .blue
        
        
        view.addSubview(pageControl)
        view.addSubview(featuresScrollView)

    }

}
