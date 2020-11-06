//
//  Authentication_Phone.swift
//  travel-note
//
//  Created by Владислав Алпеев on 23.10.2020.
//

import UIKit
import PhoneNumberKit

class Authentication_Phone: UIViewController {
    
    var viewModel: AuthentificationViewModelProtocol!{
        didSet {
            viewModel.errorDidChange = { [unowned self] viewModel in
                guard let error = viewModel.error else {return}
                self.present(error, animated: true, completion: nil)
            }
            viewModel.successDidChange = { [unowned self] viewModel in
                self.modalTransitionStyle = .flipHorizontal
                guard let success = viewModel.success else {return}
                weak var pvc = self.presentingViewController
                self.dismiss(animated: true) {
                    pvc?.present(success, animated: true)
                }
            }
        }
    }
    
    let authLable: UILabel = {
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
        
        view.addSubview(authLable)
        authLable.center.x = self.view.center.x
        
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
