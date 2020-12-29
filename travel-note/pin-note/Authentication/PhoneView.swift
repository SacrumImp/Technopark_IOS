//
//  Authentication_Phone.swift
//  travel-note
//
//  Created by Владислав Алпеев on 23.10.2020.
//

import UIKit
import PhoneNumberKit

protocol AuthenticationPhoneViewControllerProtocol {
    func sendPhone(phoneNumber: String)
}

class AuthenticationPhoneViewController: UIViewController, AuthenticationPhoneViewControllerProtocol {
    
    private var viewModel: AuthentificationViewModelProtocol!
    
    convenience init(viewModel: AuthentificationViewModelProtocol){
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    let authLabel: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 0, width: 300, height: 100))
        lable.text = "Авторизация" //STRINGS:
        lable.font = .systemFont(ofSize: 30, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let enterPhoneButton: UIButton! = {
        let button = UIButton(frame: CGRect(x: 0, y: 120, width: 300, height: 100))
        button.setTitle("Отправить код подтверждения", for: .normal) //STRINGS:
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    let phoneTextField: PhoneNumberTextField! = {
        let textField = PhoneNumberTextField(frame: CGRect(x: 0, y: 60, width: 310, height: 100))
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        textField.withFlag = true
        textField.withExamplePlaceholder = true
        textField.font = UIFont.systemFont(ofSize: 30)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(authLabel)
        authLabel.center.x = self.view.center.x
        
        view.addSubview(phoneTextField)
        phoneTextField.center.x = self.view.center.x
        
        view.addSubview(enterPhoneButton)
        enterPhoneButton.center.x = self.view.center.x
        enterPhoneButton.addTarget(self, action: #selector(enterPhone), for: .touchUpInside)
        
    }
    
    @objc
    func enterPhone() {
        guard let phoneNumber = phoneTextField.text else {return}
        sendPhone(phoneNumber: phoneNumber)
    }
    
    func sendPhone(phoneNumber: String) {
        viewModel.sendPhone(phoneNumber: phoneNumber, completion: { [weak self] (user, error) in
            guard let self = self else { return }
            switch error { //TODO: поработать с ошибками
                case .noConnection:
                    let errorPhone = UIAlertController(title: "Ошибка", message: "Не удалось авторизироваться", preferredStyle: .alert) //STRINGS:
                    errorPhone.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (_) in return}))
                    self.present(errorPhone, animated: true, completion: nil)
                default:
                    break
            }
            let authentificationViewModel = AuthentificationViewModel()
            let codeView = AuthenticationCodeViewController(viewModel: authentificationViewModel)
            codeView.modalTransitionStyle = .flipHorizontal
            codeView.modalPresentationStyle = .automatic
            self.modalTransitionStyle = .flipHorizontal
            weak var pvc = self.presentingViewController
            self.dismiss(animated: true) {
                pvc?.present(codeView, animated: true)
            }
        })
    }
}
