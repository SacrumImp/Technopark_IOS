//
//  AboutViewController.swift
//  pin-note
//
//  Created by Алексей Савельев on 29.12.2020.
//

import UIKit

class AboutViewController: UIViewController {
    
    private let theme = ThemeManager.currentTheme()
    
    private let imageView: UIImageView = {
        let height = UIScreen.main.bounds.size.height
        var imageView = UIImageView(frame: CGRect(x: 0, y: (height/4), width: 150, height: 150))
        imageView.image = UIImage(named: "loadScreenLogo")
        return imageView
    }()
    
    private let appLabel: UILabel = {
        let height = UIScreen.main.bounds.size.height
        let lable = UILabel(frame:CGRect(x: 0, y: (height/4)+165, width: 300, height: 30))
        lable.text = "PinNote" //STRINGS:
        lable.font = .systemFont(ofSize: 30, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    private let versionLabel: UILabel = {
        let height = UIScreen.main.bounds.size.height
        let lable = UILabel(frame:CGRect(x: 0, y: (height/4)+190, width: 300, height: 30))
        // получаем версию
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        lable.text = "Версия " + version //STRINGS:
        lable.font = .systemFont(ofSize: 18, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    private let textView: UITextView = {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        var textView = UITextView(frame: CGRect(x: 0, y: (height/4)+225, width: width - (40*2), height: (height/5)))
        
        textView.text = "Приложение для создания, ведения заметок, с возможность привязки к карте, разрабатываемое в рамках семестрового курса образовательного проекта 'Технопарк'"
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textAlignment = .center
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.fourthColor

        view.addSubview(appLabel)
        appLabel.center.x = self.view.center.x
        view.addSubview(versionLabel)
        versionLabel.center.x = self.view.center.x
        view.addSubview(imageView)
        imageView.center.x = self.view.center.x
        view.addSubview(textView)
        textView.center.x = self.view.center.x
        textView.backgroundColor = theme.fourthColor
    }
    

}
