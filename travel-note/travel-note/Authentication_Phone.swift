//
//  Authentication_Phone.swift
//  travel-note
//
//  Created by Владислав Алпеев on 23.10.2020.
//

import UIKit
import FirebaseAuth
import PhoneNumberKit

class Authentication_Phone: UIViewController {
    
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
        
        guard let sendPhoneNumber = phoneTextField.text else {return}
        
        PhoneAuthProvider.provider().verifyPhoneNumber(sendPhoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                let codeViewController = Authentication_Code()
                codeViewController.modalTransitionStyle = .flipHorizontal
                self.modalTransitionStyle = .flipHorizontal
                codeViewController.modalPresentationStyle = .automatic
                weak var pvc = self.presentingViewController
                self.dismiss(animated: true) {
                    pvc?.present(codeViewController, animated: true)
                }
            }
            else{
                let errorPhone = UIAlertController(title: "Ошибка", message: "Не удалось отправить СМС", preferredStyle: .alert) //STRINGS:
                errorPhone.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (_) in
                    self.dismiss(animated: true)
                })) //STRINGS:
                self.present(errorPhone, animated: true, completion: nil)
            }
        }
    }
}
