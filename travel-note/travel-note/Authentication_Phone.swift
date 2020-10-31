//
//  Authentication_Phone.swift
//  travel-note
//
//  Created by Владислав Алпеев on 23.10.2020.
//

import UIKit
import FirebaseAuth

class Authentication_Phone: UIViewController {
    
    let enterPhoneButton: UIButton! = {
        let button = UIButton(frame: CGRect(x: 55, y: 330, width: 300, height: 100))
        button.setTitle("Отправить код подтверждения", for: .normal) //STRINGS:
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    let phoneTextField: UITextField! = {
        let textField = UITextField(frame: CGRect(x: 100, y: 270, width: 400, height: 100))
        textField.placeholder = "Введите номер телефона" //STRINGS:
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(phoneTextField)
        view.addSubview(enterPhoneButton)
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
                print("Can't get verification ID") //STRINGS:
                //TODO: сделать окно для уведомления пользователя о проблемах с отправкой номера
            }
        }
    }
}
