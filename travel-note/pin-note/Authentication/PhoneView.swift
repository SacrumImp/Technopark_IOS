//
//  Authentication_Phone.swift
//  travel-note
//
//  Created by Владислав Алпеев on 23.10.2020.
//

import UIKit
import PhoneNumberKit

class AuthenticationPhoneViewController: UIViewController {
    
    var viewModel: AuthentificationViewModelProtocol!{
        didSet {
            viewModel.errorDidChange = { [weak self] viewModel in
                guard let error = viewModel.error else {return}
                error.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (_) in
                    self?.dismiss(animated: true)
                })) //STRINGS:
                self?.present(error, animated: true, completion: nil)
            }
            viewModel.successDidChange = { [weak self] viewModel in
                let codeView = AuthenticationCodeViewController()
                let authentificationViewModel = AuthentificationViewModel()
                codeView.viewModel = authentificationViewModel
                codeView.modalTransitionStyle = .flipHorizontal
                codeView.modalPresentationStyle = .automatic
                self?.modalTransitionStyle = .flipHorizontal
                weak var pvc = self?.presentingViewController
                self?.dismiss(animated: true) {
                    pvc?.present(codeView, animated: true)
                }
            }
        }
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
        enterPhoneButton.addTarget(self, action: #selector(enterPhone(sender:)), for: .touchUpInside)
        
    }
    
    @objc func enterPhone(sender: UIButton) {
        guard let phoneNumber = phoneTextField.text else {return}
        viewModel.sendPhone(phoneNumber: phoneNumber)
    }
}
