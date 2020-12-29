//
//  Authentication_Code.swift
//  travel-note
//
//  Created by Владислав Алпеев on 25.10.2020.
//

import UIKit
import FirebaseAuth

protocol AuthenticationCodeViewControllerProtocol {
    func sendCode(code: String)
}

class AuthenticationCodeViewController: UIViewController, AuthenticationCodeViewControllerProtocol {
    
    private var viewModel: AuthentificationViewModelProtocol!
    
    private let theme = ThemeManager.currentTheme()
    
    convenience init(viewModel: AuthentificationViewModelProtocol){
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    let codeLabel: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 0, width: 300, height: 100))
        lable.text = "Код подтверждения" //STRINGS:
        lable.font = .systemFont(ofSize: 30, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let enterCodeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 120, width: 300, height: 100))
        button.setTitle("Подтвердить", for: .normal) //STRINGS:
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    let codeTextField: UITextField! = {
        let textField = UITextField(frame: CGRect(x: 0, y: 60, width: 130, height: 100))
        textField.placeholder = "Код" //STRINGS:
        textField.textContentType = .oneTimeCode
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.becomeFirstResponder()
        textField.textAlignment = .center
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.fourthColor
        
        view.addSubview(codeLabel)
        codeLabel.center.x = self.view.center.x
        
        view.addSubview(codeTextField)
        codeTextField.center.x = self.view.center.x
        
        view.addSubview(enterCodeButton)
        enterCodeButton.center.x = self.view.center.x
        enterCodeButton.addTarget(self, action: #selector(enterCode), for: .touchUpInside)
    }
    
    @objc
    func enterCode() {
        
        guard let verificationCode  = codeTextField.text else {return}
        sendCode(code: verificationCode)
        
    }
    
    func sendCode(code: String) {
        viewModel.sendCode(code: code, completion: { [weak self] (user, error) in
            guard let self = self else { return }
            switch error { //TODO: поработать с ошибками
                case .noConnection:
                    let errorCode = UIAlertController(title: "Ошибка", message: "Не удалось авторизироваться", preferredStyle: .alert) //STRINGS:
                    errorCode.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (_) in return}))
                    self.present(errorCode, animated: true, completion: nil)
                default:
                    break
            }
            self.modalTransitionStyle = .coverVertical
            self.parent?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            let settingsView = SettingsViewController()
            let navVC = UINavigationController(rootViewController: settingsView)
            navVC.modalTransitionStyle = .crossDissolve
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
        })
    }
}
