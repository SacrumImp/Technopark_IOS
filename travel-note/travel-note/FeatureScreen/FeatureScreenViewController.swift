//
//  FeatureScreenViewController.swift
//  travel-note
//
//  Created by Алексей Савельев on 02.11.2020.
//

import UIKit

class FeatureScreenViewController: UIViewController {
    
    private let titleList = ["Добро пожаловать в приложение TravelNote",
                             "Умное слово",
                             "Другое умное слово",
                             "И тд."]
    private let bodyList  = ["Спасибо за установку нашего приложения для путешественников",
                             "Объяснение чегото, связанного с Умным словом",
                             "Объяснение чегото другого, связанного с умным словом",
                             "И тд."]
    
    let titleLable = UILabel()
    let bodyLable = UILabel()
//    TODO: Доделать сетап для заголовков
//    fileprivate func setupLables(_ iter: Int) {
//        titleLable.backgroundColor = .red
//        titleLable.font = UIFont(name: "Futura", size: 20)
//        titleLable.text = titleList[iter]
//        titleLable.numberOfLines = 0
//
//        bodyLable.backgroundColor = .green
//        bodyLable.text = bodyList[iter]
//        bodyLable.numberOfLines = 0
//
//    }

//    TODO: Доделать сетап для стаквью
//    fileprivate func setupStackView() {
//        let stackView = UIStackView(arrangedSubviews: [titleLable, bodyLable])
//
////        stackView.axis = .vertical
////        stackview.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
//        self.view.addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
//    }
    
    private let featuresScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.indicatorStyle = .white
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .systemBackground
        pageControl.tintColor = .gray
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .gray
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuresScrollView.delegate = self
        featuresScrollView.backgroundColor = .systemBackground
        
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            pageControl.currentPageIndicatorTintColor = .white
            featuresScrollView.indicatorStyle = .black
        }
        
        view.backgroundColor = .systemBackground
        view.addSubview(pageControl)
        view.addSubview(featuresScrollView)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        featuresScrollView.setContentOffset(CGPoint(x: CGFloat(current)*view.frame.size.width, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10,
                                   y: view.frame.size.height-90,
                                   width: view.frame.size.width-20,
                                   height: 70)
        
        featuresScrollView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.size.width,
                                          height: view.frame.size.height-90)
        
        if featuresScrollView.subviews.count == 2 {
            configureScrollView()
        }
    }
    
    private func configureScrollView() {
        featuresScrollView.contentSize = CGSize(width: view.frame.size.width*3,
                                                height: featuresScrollView.frame.size.height)
        featuresScrollView.isPagingEnabled = true
//        let colors: [UIColor] = [
//            .blue,
//            .cyan,
//            .magenta
//        ]
        for x in 0..<3 {
            let page = UIView(frame: CGRect(
                                x: CGFloat(x)*view.frame.size.width,
                                y: 0,
                                width: view.frame.size.width,
                                height: featuresScrollView.frame.size.height))
            page.backgroundColor = .systemBackground
//            setupLables(x)
//            setupStackView()
            featuresScrollView.addSubview(page)
        }
    }
    
}

extension FeatureScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
}

